// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/user_dto.dart';
import '../../fixtures/mock_firebase_extensions.dart';
import '../../fixtures/user.dart';

void main() {
  late FakeFirebaseFirestore fs;

  setUp(() async {
    fs = FakeFirebaseFirestore();
  });

  group('fromDomain()', () {
    test(
      'should return DTO',
      () async {
        // act
        final result = UserDto.fromDomain(dummyUserOne);
        // assert
        expect(result, equals(dummyUserOneDto));
      },
    );
  });
  group('toDomain()', () {
    test(
      'should return Domain Object',
      () {
        // act
        final result = dummyUserOneDto.toDomain();
        // assert
        expect(result, equals(dummyUserOne));
      },
    );
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange
        await fs.populateWithUser(dummyUserOne);
        final snapshot = await fs.getUserDoc(dummyUserOne.id);

        // act
        final res = UserDto.fromFireStore(snapshot);
        // assert
        expect(res, equals(dummyUserOneDto));
      },
    );
  });
  group('toFirestore()', () {
    test(
      'should return firestore map',
      () {
        // act
        final res = dummyUserOneDto.toFireStore();
        // assert
        expect(res, equals(dummyUserOneAsFirebaseMap));
      },
    );
  });
}
