// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_item_dto.dart';
import '../../fixtures/chatbots/diary/answer_items_diary.dart';
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
        final res = AnswerItemDto.fromDomain(answerItemDayGoodMonday);
        // assert
        expect(res, equals(answerItemDayGoodAsDto));
      },
    );
  });
  group('toDomain()', () {
    test('should return Domain Object', () {
      // act
      final res = answerItemDayGoodAsDto.toDomain();
      // assert
      expect(res, equals(answerItemDayGoodMonday));
    });
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange
        await fs.populateWithAnswerItem(answerItemDayGoodMonday);

        final snapshot = await fs.getAnswerItemDoc(
          userId: answerItemDayGoodMonday.createdBy,
          chatBotId: answerItemDayGoodMonday.chatBotId,
          anserItemId: answerItemDayGoodMonday.id,
        );

        // act
        final res = AnswerItemDto.fromFireStore(snapshot);

        // assert
        expect(res, equals(answerItemDayGoodAsDto));
      },
    );
  });
  group('toFirestore()', () {
    test(
      'should return firestore map',
      () {
        // arrange
        final dto = AnswerItemDto.fromDomain(answerItemDayGoodMonday);
        // act
        final res = dto.toFireStore();
        // assert
        expect(res, equals(answerItemDayGoodMondayAsFirestoreMap));
      },
    );
  });
}
