// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_item_dto.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';

@LazySingleton(as: IAnswerItemWatcherApi)
class FireBaseAnswerItemWatcherApi implements IAnswerItemWatcherApi {
  final FirebaseFirestore fs;
  final IAuthRepo authRepo;

  FireBaseAnswerItemWatcherApi(
    this.fs,
    this.authRepo,
  );

  @override
  Stream<Either<CrudFailure, KtList<AnswerItem>>>
      watchAllOfChatBotAndSignedInUser(UniqueId chatBotId) async* {
    late UniqueId userId;
    try {
      userId = await authRepo.getSignedInUserId();
    } catch (e) {
      yield left<CrudFailure, KtList<AnswerItem>>(
          const CrudFailure.notSignedIn());
    }

    yield* fs
        .answerItemsOf(userId: userId, chatBotId: chatBotId)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<AnswerItem>>(snapshot.docs
            .map((doc) => AnswerItemDto.fromFireStore(doc).toDomain())
            .toImmutableList());
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerItem>>> watchAllOfQar(
      UniqueId qarId) async* {
    late UniqueId userId;
    late Qar qar;
    try {
      await fs.queryOfQar(qarId: qarId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            qar = QarDto.fromFireStore(docs.first).toDomain();
          } else {
            throw Exception();
          }
        },
      );

      userId = await authRepo.getSignedInUserId();

      if (userId != qar.createdBy) {
        yield left<CrudFailure, KtList<AnswerItem>>(
            const CrudFailure.insufficientPermission());
      }
    } catch (e) {
      yield left<CrudFailure, KtList<AnswerItem>>(
          const CrudFailure.notSignedIn());
    }

    yield* fs
        .answerItemsOf(
          userId: qar.createdBy,
          chatBotId: qar.chatBotId,
        )
        .where(
          QAR_ID,
          isEqualTo: qar.id.getOrCrash(),
        )
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<AnswerItem>>(snapshot.docs
            .map((doc) => AnswerItemDto.fromFireStore(doc).toDomain())
            .toImmutableList());
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerItem>>>
      watchAllOfQuestionAndSignedInUser(UniqueId questionId) async* {
    late UniqueId userId;
    try {
      userId = await authRepo.getSignedInUserId();
    } catch (e) {
      yield left<CrudFailure, KtList<AnswerItem>>(
          const CrudFailure.notSignedIn());
    }
    final chatBotId = await fs
        .queryOfQuestion(questionId: questionId)
        .get()
        .then((snapshot) => snapshot.docs.first.get(CHAT_BOT_ID) as String);

    yield* fs
        .answerItemsOf(
            userId: userId, chatBotId: UniqueId.fromUniqueString(chatBotId))
        .where(QUESTION_ID, isEqualTo: questionId.getOrCrash())
        .orderBy(CREATED_AT, descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return right<CrudFailure, KtList<AnswerItem>>(snapshot.docs
            .map((doc) => AnswerItemDto.fromFireStore(doc).toDomain())
            .toImmutableList());
      },
    ).onErrorReturnWith((e, stackTrace) {
      return left(convertToCrudFailure(e));
    });
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerItem>>> watchAllOfParentEntity(
      UniqueId id) {
    return watchAllOfQar(id);
  }

  @override
  Stream<Either<CrudFailure, KtList<AnswerItem>>> watchOne(UniqueId id) async* {
    yield* fs.queryOfAnswerItem(answerItemId: id).snapshots().map(
      (snapshot) {
        final docs = snapshot.docs;
        if (docs.isNotEmpty) {
          return right<CrudFailure, KtList<AnswerItem>>(
            docs
                .map((doc) => AnswerItemDto.fromFireStore(doc).toDomain())
                .toImmutableList(),
          );
        } else {
          return left<CrudFailure, KtList<AnswerItem>>(
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
}
