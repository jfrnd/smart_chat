// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_user_crud_api.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseUserCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseUserCrudApi(fs);

    await fs.populateWithUser(dummyUserOne);
  });

  group('readOne()', () {
    test(
      'should return dummyUserOne',
      () async {
        // act
        final res = await repo.readOne(dummyUserOne.id);
        // assert
        expectLater(res, right<CrudFailure, User>(dummyUserOne));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readOne(UniqueId());
        // assert
        expectLater(
            res, left<CrudFailure, User>(const CrudFailure.doesNotExist()));
      },
    );
  });
  group('createOnDB()', () {
    test(
      '''should add user to fs and return right(unit)''',
      () async {
        // act
        final response = await repo.createOnDB(dummyUserTwo);
        // assert
        final userOnFs = await fs.getUserOrNull(dummyUserTwo.id);
        expectLater(response, equals(const Right(unit)));
        expectLater(userOnFs, equals(dummyUserTwo));
      },
    );
  });
  group('updateOnDB()', () {
    test(
      'should update user on fs and return right(unit)',
      () async {
        // arrange
        final updatedDomainUser = dummyUserOne.copyWith(
          imageUrl: ImageUrl(""),
        );
        // act
        final response = await repo.updateOnDB(updatedDomainUser);
        // assert
        final updatedUserOnFs = await fs.getUserOrNull(dummyUserOne.id);

        expectLater(response, equals(const Right(unit)));
        expectLater(updatedUserOnFs, equals(updatedDomainUser));
      },
    );
  });
  group('deleteFromDB()', () {
    test(
      'should delete user from fs and return right(unit)',
      () async {
        // arrange
        fs.populateWithUser(dummyUserTwo);

        // act
        final response = await repo.deleteFromDB(dummyUserTwo);

        // assert

        final doc = await fs.getUserOrNull(dummyUserTwo.id);
        final doc2 = await fs.getUserOrNull(dummyUserOne.id);

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
}
