// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/user_dto.dart';

@LazySingleton(as: IUserCrudApi)
class FireBaseUserCrudApi implements IUserCrudApi {
  final FirebaseFirestore fs;

  FireBaseUserCrudApi(
    this.fs,
  );

  @override
  Future<Either<CrudFailure, User>> readOne(UniqueId userId) async {
    try {
      return fs.users.doc(userId.getOrCrash()).get().then(
        (snapshot) {
          if (snapshot.exists) {
            return Right(
              UserDto.fromFireStore(snapshot).toDomain(),
            );
          } else {
            return left<CrudFailure, User>(
              const CrudFailure.doesNotExist(),
            );
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(User user) async {
    try {
      await fs.users
          .doc(user.id.getOrCrash())
          .set(UserDto.fromDomain(user).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(User user) async {
    try {
      await fs.users
          .doc(user.id.getOrCrash())
          .update(UserDto.fromDomain(user).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(User user) async {
    try {
      await fs.users.doc(user.id.getOrCrash()).delete();
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
