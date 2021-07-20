// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';

@LazySingleton(as: IQarWatcherApi)
class FireBaseQarWatcherApi implements IQarWatcherApi {
  final FirebaseFirestore fs;
  final IAuthRepo authRepo;
  final IChatBotWatcherApi chatBotRepoWatcher;
  final IQuestionWatcherApi questionRepoWatcher;

  FireBaseQarWatcherApi(
    this.fs,
    this.authRepo,
    this.chatBotRepoWatcher,
    this.questionRepoWatcher,
  );

  @override
  Stream<Either<CrudFailure, KtList<Qar>>> watchOne(UniqueId qarId) async* {
    late UniqueId userId;
    try {
      userId = await authRepo.getSignedInUserId();
    } catch (e) {
      yield left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn());
    }

    yield* fs.queryOfQar(qarId: qarId).snapshots().map(
      (snapshot) {
        final docs = snapshot.docs;
        if (docs.isNotEmpty) {
          final qar = QarDto.fromFireStore(docs.first).toDomain();
          return qar.createdBy == userId
              ? right<CrudFailure, KtList<Qar>>(listOf(qar))
              : left<CrudFailure, KtList<Qar>>(
                  const CrudFailure.insufficientPermission(),
                );
        } else {
          return left<CrudFailure, KtList<Qar>>(
            const CrudFailure.doesNotExist(),
          );
        }
      },
    ).onErrorReturnWith(
      (e, stackTrace) {
        return left(
          convertToCrudFailure(e),
        );
      },
    );
  }

  @override
  Stream<Either<CrudFailure, KtList<Qar>>> watchAllOfChatBot(
      UniqueId chatBotId) async* {
    late UniqueId userId;
    try {
      userId = await authRepo.getSignedInUserId();
    } catch (e) {
      yield left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn());
    }
    yield* fs
        .qars(userId: userId, chatBotId: chatBotId)
        .orderBy(CREATED_AT, descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<Qar>>(
          snapshot.docs
              .map((doc) => QarDto.fromFireStore(doc).toDomain())
              .toImmutableList(),
        );
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<Qar>>> watchAllOfQuestion(
      UniqueId questionId) async* {
    late UniqueId userId;
    try {
      userId = await authRepo.getSignedInUserId();
    } catch (e) {
      yield left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn());
    }

    final chatBotId = await fs
        .queryOfQuestion(questionId: questionId)
        .get()
        .then((snapshot) => snapshot.docs.first.get(CHAT_BOT_ID) as String);

    yield* fs
        .qars(userId: userId, chatBotId: UniqueId.fromUniqueString(chatBotId))
        .where(QUESTION_ID, isEqualTo: questionId.getOrCrash())
        .orderBy(CREATED_AT, descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<Qar>>(
          snapshot.docs
              .map((doc) => QarDto.fromFireStore(doc).toDomain())
              .toImmutableList(),
        );
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<Qar>>> watchAllVisibleOfChatBot(
      UniqueId chatBotId) async* {
    late UniqueId userId;
    try {
      userId = await authRepo.getSignedInUserId();
    } catch (e) {
      yield left<CrudFailure, KtList<Qar>>(const CrudFailure.notSignedIn());
    }

    yield* fs
        .qars(userId: userId, chatBotId: chatBotId)
        .orderBy(VISIBLE_SINCE, descending: true)
        .where(IS_VISIBLE, isEqualTo: true)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<Qar>>(
          snapshot.docs
              .map((doc) => QarDto.fromFireStore(doc).toDomain())
              .toImmutableList(),
        );
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<KtMap<UniqueId, Either<CrudFailure, Qar?>>>
      watchUnreadOrMostRecentQarOfChatBots(
    KtList<UniqueId> chatBotIds,
    UniqueId userId,
  ) async* {
    final streams = chatBotIds
        .map((id) =>
            watchMostRecentUnansweredAndVisibleOrMostRecentAnswered(id, userId))
        .asList();
    yield* CombineLatestStream(
        streams,
        (List<Either<CrudFailure, Qar?>> s) => s
            .toImmutableList()
            .mapIndexed((idx, s) => KtPair(chatBotIds[idx], s))
            .associateByTransform((p) => p.first, (p) => p.second));
  }

  Stream<Either<CrudFailure, Qar?>>
      watchMostRecentUnansweredAndVisibleOrMostRecentAnswered(
    UniqueId chatBotId,
    UniqueId userId,
  ) async* {
    yield* watchMostRecentUnansweredAndVisibleQar(chatBotId, userId)
        .onErrorReturnWith(
            (e, _) => left<CrudFailure, Qar?>(convertToCrudFailure(e)))
        .switchMap(
          (failureOrQar) => failureOrQar.fold(
            (f) => Stream.value(left<CrudFailure, Qar?>(f)),
            (qar) => qar != null
                ? watchMostRecentUnansweredAndVisibleQar(chatBotId, userId)
                : watchMostRecentAnsweredQar(chatBotId, userId),
          ),
        )
        .onErrorReturnWith(
            (e, _) => left<CrudFailure, Qar?>(convertToCrudFailure(e)));
  }

  Stream<Either<CrudFailure, Qar?>> watchMostRecentUnansweredAndVisibleQar(
    UniqueId chatBotId,
    UniqueId userId,
  ) async* {
    yield* fs
        .qars(userId: userId, chatBotId: chatBotId)
        .where(IS_ANSWERED, isEqualTo: false)
        .where(IS_VISIBLE, isEqualTo: true)
        .orderBy(VISIBLE_SINCE, descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty
            ? right<CrudFailure, Qar?>(
                QarDto.fromFireStore(snapshot.docs.first).toDomain())
            : right<CrudFailure, Qar?>(null))
        .onErrorReturnWith(
            (e, _) => left<CrudFailure, Qar?>(convertToCrudFailure(e)));
  }

  Stream<Either<CrudFailure, Qar?>> watchMostRecentAnsweredQar(
    UniqueId chatBotId,
    UniqueId userId,
  ) async* {
    yield* fs
        .qars(userId: userId, chatBotId: chatBotId)
        .where(IS_ANSWERED, isEqualTo: true)
        .orderBy(VISIBLE_SINCE, descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty
            ? right<CrudFailure, Qar?>(
                QarDto.fromFireStore(snapshot.docs.first).toDomain())
            : right<CrudFailure, Qar?>(null))
        .onErrorReturnWith(
            (e, _) => left<CrudFailure, Qar?>(convertToCrudFailure(e)));
  }

  @override
  Stream<Either<CrudFailure, KtList<Qar>>> watchAllOfParentEntity(UniqueId id) {
    return watchAllOfChatBot(id);
  }
}
