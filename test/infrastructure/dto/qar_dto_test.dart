// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/qar_dto.dart';
import '../../fixtures/chatbots/diary/qars_diary.dart';
import '../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;

  setUp(() async {
    fs = FakeFirebaseFirestore();
  });
  group('fromDomain()', () {
    test(
      'should return DTO',
      () {
        // act

        final result = QarDto.fromDomain(qarDayMonday);
        // assert
        expect(result, equals(qarDayAsDto));
      },
    );
  });
  group('toDomain()', () {
    test(
      'should return Domain Object',
      () {
        // act
        final result = qarDayAsDto.toDomain();
        // assert
        expect(result, equals(qarDayMonday));
      },
    );
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange

        await fs.populateWithQar(qarDayMonday);

        final docSnapshot = await fs.getQarDoc(
          userId: qarDayMonday.createdBy,
          chatBotId: qarDayMonday.chatBotId,
          qarId: qarDayMonday.id,
        );

        // act
        final result = QarDto.fromFireStore(docSnapshot);

        // assert
        expect(result, equals(qarDayAsDto));
      },
    );
  });
  group('toFireStore()', () {
    test(
      'should return firestore map',
      () {
        // act
        final result = qarDayAsDto.toFireStore();

        // assert
        expect(result, equals(qarDayAsFirestoreMap));
      },
    );
  });
}
