// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_option_dto.dart';
import '../../fixtures/chatbots/diary/answer_options_diary.dart';
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
        final res = AnswerOptionDto.fromDomain(answerOptionDayGood);
        // assert
        expect(res, equals(answerOptionDayGoodAsDto));
      },
    );
  });
  group('toDomain()', () {
    test('should return Domain Object', () {
      // act
      final res = answerOptionDayGoodAsDto.toDomain();
      // assert
      expect(res, equals(answerOptionDayGood));
    });
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange

        await fs.populateWithAnswerOption(answerOptionDayGood);

        final snapshot = await fs.getAnswerOptionDoc(
          chatBotId: answerOptionDayGood.chatBotId,
          questionId: answerOptionDayGood.questionId,
          answerOptionId: answerOptionDayGood.id,
        );

        // act
        final res = AnswerOptionDto.fromFireStore(snapshot);

        // assert
        expect(res, equals(answerOptionDayGoodAsDto));
      },
    );
  });
  group('toFirestore()', () {
    test(
      'should return firestore map',
      () {
        // arrange
        final dto = AnswerOptionDto.fromDomain(answerOptionDayGood);
        // act
        final res = dto.toFireStore();

        // assert
        expect(res, equals(answerOptionDayGoodAsFirestoreMap));
      },
    );
  });
}
