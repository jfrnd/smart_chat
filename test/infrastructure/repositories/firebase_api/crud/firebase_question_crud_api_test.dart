// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_question_repo_crud_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/chatbots/fitness/questions_fitness.dart';
import '../../../../fixtures/chatbots/politics/questions_politics.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseQuestionCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseQuestionCrudApi(fs);

    // ChatBot: Diary
    await fs.populateWithQuestion(questionDay);
    await fs.populateWithQuestion(questionSleep);
    // ChatBot: Politics
    await fs.populateWithQuestion(questionVote);
  });

  group('readOne()', () {
    test(
      'should return questionDay',
      () async {
        // act
        final res = await repo.readOne(questionDay.id);
        // assert
        expectLater(res, equals(right(questionDay)));
      },
    );
    test(
      'should return CrudFailure.doesNotExist() when doc does not exist',
      () async {
        // act
        final res = await repo.readOne(UniqueId());
        // assert
        expectLater(res, equals(left(const CrudFailure.doesNotExist())));
      },
    );
  });
  group('readAllOfChatBot()', () {
    test(
      'should return a list containing only the questions of chatBotDiary',
      () async {
        // act
        final res = await repo.readAllOfChatBot(chatBotDiary.id);
        // assert
        expectLater(res, equals(right(listOf(questionDay, questionSleep))));
      },
    );
  });
  group('createOnDB()', () {
    test(
      'should add question to fs and return right(unit)',
      () async {
        // act
        final response = await repo.createOnDB(questionKM);
        // assert

        final questionOnFs = await fs.getQuestionOrNull(
          chatBotId: questionKM.chatBotId,
          questionId: questionKM.id,
        );

        expectLater(questionOnFs, equals(questionKM));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('updateOnDB()', () {
    test(
      'should update question on fs and return right(unit)',
      () async {
        // arrange
        final updatedQuestionDay =
            questionDay.copyWith(translations: questionBodyLangMapDayExtended);
        // act
        final response = await repo.updateOnDB(updatedQuestionDay);
        // assert

        final updatedQuestionOnFs = await fs.getQuestionOrNull(
          chatBotId: questionDay.chatBotId,
          questionId: questionDay.id,
        );

        expectLater(updatedQuestionOnFs, equals(updatedQuestionDay));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('deleteFromDB()', () {
    test(
      'should delete question from fs and return right(unit)',
      () async {
        // act
        final response = await repo.deleteFromDB(questionDay);
        // assert

        final doc = await fs.getQuestionOrNull(
          chatBotId: questionDay.chatBotId,
          questionId: questionDay.id,
        );
        final doc2 = await fs.getQuestionOrNull(
          chatBotId: questionSleep.chatBotId,
          questionId: questionSleep.id,
        );

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('readCurrentNumberOfQuestions()', () {
    test(
      'should return Right(0) when there are no questions yet',
      () async {
        // act
        final response = await repo.readCurrentNumberOfQuestions(UniqueId());
        // assert
        expectLater(response, equals(const Right(0)));
      },
    );
    test(
      'should return Right(3) when there already 3 questions added',
      () async {
        // arrange
        await fs.populateWithQuestion(questionActivity);
        // act
        final response =
            await repo.readCurrentNumberOfQuestions(questionDay.chatBotId);
        // assert
        expectLater(response, equals(const Right(3)));
      },
    );
  });
}
