// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';

@LazySingleton(as: IImageCrudApi)
class FireBaseImageCrudApi implements IImageCrudApi {
  final FirebaseStorage firebaseStorage;

  FireBaseImageCrudApi(
    this.firebaseStorage,
  );

  @override
  Future<Either<CrudFailure, String>> updateImage(
      {required String remoteImagePath, required String localImagePath}) async {
    try {
      await firebaseStorage
          .ref()
          .child(remoteImagePath)
          .putFile(File(localImagePath));

      final downloadUrl =
          await firebaseStorage.ref().child(remoteImagePath).getDownloadURL();

      return Right(downloadUrl);
    } catch (e) {
      return const Left(CrudFailure.imageFailure());
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteImage(String remoteImagePath) async {
    try {
      await firebaseStorage.ref().child(remoteImagePath).delete();
      return const Right(unit);
    } catch (e) {
      return const Left(CrudFailure.imageFailure());
    }
  }
}
