// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: IQarCrudRepo)
class ClientQarCrud implements IQarCrudRepo {
  final IAuthRepo authRepo;
  final IMetaDataProvider metaDataProvider;
  final IQarCrudApi crudApi;
  final IQuestionCrudApi questionCrudApi;

  ClientQarCrud(
    this.authRepo,
    this.metaDataProvider,
    this.crudApi,
    this.questionCrudApi,
  );

  @override
  Future<Either<CrudFailure, Qar>> readOne(UniqueId qarId) async {
    return verifyUserAndReadOne(qarId);
  }

  Future<Either<CrudFailure, Qar>> verifyUserAndReadOne(UniqueId qarId) async {
    final userId = await authRepo.getSignedInUserId();

    return crudApi.readOne(qarId).then(
          (failureOrQar) => failureOrQar.fold(
            (f) => left<CrudFailure, Qar>(f),
            (qar) => qar.createdBy != userId
                ? left<CrudFailure, Qar>(
                    const CrudFailure.insufficientPermission())
                : right<CrudFailure, Qar>(qar),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Qar>> create(Qar qar) async {
    return createWithMetaData(qar);
  }

  Future<Either<CrudFailure, Qar>> createWithMetaData(Qar qar) async {
    final userId = await authRepo.getSignedInUserId();

    final newQar = qar.addMetaData(
      id: metaDataProvider.getUniqueId(),
      createdBy: userId,
      createdAt: metaDataProvider.getCurrentTime(),
    );

    return crudApi.createOnDB(newQar).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, Qar>(f),
            (_) => right<CrudFailure, Qar>(newQar),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Qar>> update(Qar qar) async {
    return verifyUserAndUpdate(qar);
  }

  Future<Either<CrudFailure, Qar>> verifyUserAndUpdate(Qar qar) async {
    final userId = await authRepo.getSignedInUserId();
    if (userId != qar.createdBy) {
      return const Left(CrudFailure.insufficientPermission());
    } else {
      return crudApi.updateOnDB(qar).then(
            (failureOrUnit) => failureOrUnit.fold(
              (f) => left<CrudFailure, Qar>(f),
              (_) => right<CrudFailure, Qar>(qar),
            ),
          );
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId qarId) async {
    return verifyUserAndDelete(qarId);
  }

  Future<Either<CrudFailure, Unit>> verifyUserAndDelete(UniqueId qarId) async {
    final userId = await authRepo.getSignedInUserId();

    return crudApi.readOne(qarId).then(
          (failureOrQar) => failureOrQar.fold(
            (f) => left<CrudFailure, Unit>(f),
            (qar) {
              if (qar.createdBy != userId) {
                return left<CrudFailure, Unit>(
                    const CrudFailure.insufficientPermission());
              } else {
                return crudApi.deleteFromDB(qar);
              }
            },
          ),
        );
  }

  @override
  Future<Either<CrudFailure, UniqueId>> createSession({
    required UniqueId chatBotId,
  }) async {
    try {
      final sessionId = metaDataProvider.getSessionId();

      return questionCrudApi.readAllOfChatBot(chatBotId).then(
            (failureOrQuestions) => failureOrQuestions.fold(
              (failure) => left(failure),
              (questions) {
                final tasks = List.generate(
                  questions.size,
                  (index) {
                    final q = questions[index];
                    final newQar =
                        Qar.createWithQuestion(q).linkWithSession(sessionId);

                    return create(index == 0
                        ? newQar.makeVisible(metaDataProvider.getCurrentTime())
                        : newQar);
                  },
                );

                return Future.wait(tasks).then(
                  (createResponses) {
                    if (createResponses.haveAnyFailure) {
                      return createResponses.firstFailure;
                    } else if (createResponses.isEmpty) {
                      return const Left(CrudFailure.unexpected(
                          info: 'chatbot has no questions'));
                    } else {
                      return Right(sessionId);
                    }
                  },
                );
              },
            ),
          );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}

extension ResponsesX on List<Either<CrudFailure, Qar>> {
  Either<CrudFailure, UniqueId> get firstFailure => firstWhere(
        (failureOrUnit) => failureOrUnit.isLeft(),
      ).fold(
        (failure) => Left(failure),
        (_) => throw Exception(),
      );
  bool get haveAnyFailure => any((failureOrUnit) => failureOrUnit.isLeft());
}
