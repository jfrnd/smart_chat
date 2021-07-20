// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/question_dto.dart';
import '../../fixtures/chatbots/diary/questions_diary.dart';
import '../../fixtures/chatbots/fitness/questions_fitness.dart';
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
        final res = QuestionDto.fromDomain(questionDay);
        // assert
        expect(res, equals(questionDayAsDto));
      },
    );

    test(
      'should return DTO (Numeric Question)',
      () {
        // act
        final res = QuestionDto.fromDomain(questionKM);
        // assert
        expect(res, equals(questionKMAsDto));
      },
    );
  });
  group('toDomain()', () {
    test('should return Domain Object', () {
      // act
      final res = questionDayAsDto.toDomain();
      // assert
      expect(res, equals(questionDay));
    });
    test(
      'should return Domain Object (Numeric Question)',
      () {
        // act
        final res = questionKMAsDto.toDomain();
        // assert
        expect(res, equals(questionKM));
      },
    );
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange
        await fs.populateWithQuestion(questionDay);
        final snapshot = await fs.getQuestionDoc(
          chatBotId: questionDay.chatBotId,
          questionId: questionDay.id,
        );

        // act
        final res = QuestionDto.fromFireStore(snapshot);

        // assert
        expect(res, equals(questionDayAsDto));
      },
    );

    test(
      'should return DTO (Numeric Question)',
      () async {
        // arrang

        await fs.populateWithQuestion(questionKM);

        final snapshot = await fs
            .questions(chatBotId: questionKM.chatBotId)
            .doc(questionKM.id.getOrCrash())
            .get();

        // act
        final res = QuestionDto.fromFireStore(snapshot);
        // assert
        expect(res, equals(questionKMAsDto));
      },
    );
  });
  group('toFirestore()', () {
    test(
      'should return firestore map',
      () {
        // arrange

        final dto = QuestionDto.fromDomain(questionDay);
        // act
        final res = dto.toFireStore();

        // assert
        expect(res, equals(questionDayAsFirestoreMap));
      },
    );
    test(
      'should return firestore map (Numeric Question)',
      () {
        // arrange

        final dto = QuestionDto.fromDomain(questionKM);
        // act
        final res = dto.toFireStore();

        // assert
        expect(res, equals(questionKMAsFirestoreMap));
      },
    );
  });
}
