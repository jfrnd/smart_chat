// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';

@LazySingleton(as: IQarCrudApi)
class FireBaseQarCrudApi implements IQarCrudApi {
  final FirebaseFirestore fs;

  FireBaseQarCrudApi(
    this.fs,
  );

  @override
  Future<Either<CrudFailure, Qar>> readOne(UniqueId qarId) async {
    try {
      return fs.queryOfQar(qarId: qarId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right(QarDto.fromFireStore(docs.first).toDomain());
          } else {
            return left(const CrudFailure.doesNotExist());
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(Qar qar) async {
    try {
      await fs
          .qars(userId: qar.createdBy, chatBotId: qar.chatBotId)
          .doc(qar.id.getOrCrash())
          .set(QarDto.fromDomain(qar).toFireStore());

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(Qar qar) async {
    try {
      await fs
          .qars(userId: qar.createdBy, chatBotId: qar.chatBotId)
          .doc(qar.id.getOrCrash())
          .update(QarDto.fromDomain(qar).toFireStore());

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(Qar qar) async {
    try {
      await fs
          .qars(
            userId: qar.createdBy,
            chatBotId: qar.chatBotId,
          )
          .doc(qar.id.getOrCrash())
          .delete();

      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, KtList<Qar>>> readAllOfSession(
      UniqueId sessionId) async {
    try {
      return fs.queryOfQarsBySessionId(sessionId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right<CrudFailure, KtList<Qar>>(
              docs
                  .map((doc) => QarDto.fromFireStore(doc).toDomain())
                  .toImmutableList(),
            );
          } else {
            return left(const CrudFailure.doesNotExist());
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Qar>> readBySessionIdAndPosition(
    UniqueId sessionId,
    int position,
  ) async {
    try {
      return fs
          .queryOfQarBySessionIdAndPosition(sessionId, position)
          .get()
          .then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right(QarDto.fromFireStore(docs.first).toDomain());
          } else {
            return left(const CrudFailure.doesNotExist());
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
