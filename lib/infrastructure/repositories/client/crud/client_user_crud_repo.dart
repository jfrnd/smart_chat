// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@LazySingleton(as: IUserCrudRepo)
class ClientUserCrud implements IUserCrudRepo {
  final IMetaDataProvider metaDataProvider;
  final IUserCrudApi crudApi;

  ClientUserCrud(
    this.metaDataProvider,
    this.crudApi,
  );

  @override
  Future<Either<CrudFailure, User>> readOne(UniqueId userId) async =>
      crudApi.readOne(userId);

  @override
  Future<Either<CrudFailure, User>> create(User user) async {
    return crudApi.createOnDB(user).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, User>(f),
            (r) => right(user),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, User>> update(User user) async {
    return crudApi.updateOnDB(user).then(
          (failureOrUnit) => failureOrUnit.fold(
            (f) => left<CrudFailure, User>(f),
            (r) => right(user),
          ),
        );
  }

  @override
  Future<Either<CrudFailure, Unit>> delete(UniqueId userId) async {
    return crudApi.readOne(userId).then(
          (failureOrUser) => failureOrUser.fold(
            (f) => left<CrudFailure, Unit>(f),
            (user) => crudApi.deleteFromDB(user),
          ),
        );
  }
}
