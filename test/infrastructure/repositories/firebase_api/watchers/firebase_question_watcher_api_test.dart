// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_question_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/chatbots/politics/questions_politics.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseQuestionWatcherApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseQuestionWatcherApi(
      fs,
    );

    // ChatBot: Diary
    await fs.populateWithQuestion(questionDay);
    await fs.populateWithQuestion(questionSleep);
    // ChatBot: Politics
    await fs.populateWithQuestion(questionVote);
  });

  group('watchOne()', () {
    test(
      'should stream a list containing only questionDay',
      () async {
        // act
        final stream = repo.watchOne(questionDay.id);
        // assert
        expectLater(stream,
            emits(right<CrudFailure, KtList<Question>>(listOf(questionDay))));
      },
    );
    test(
      'should stream CrudFailure.doesNotExist() when doc does not exist',
      () async {
        // act
        final stream = repo.watchOne(UniqueId());
        // assert
        expectLater(
            stream,
            emits(left<CrudFailure, KtList<Question>>(
                const CrudFailure.doesNotExist())));
      },
    );
  });
  group('watchAllOfChatBot()', () {
    test(
      'should stream a list containing only the questions of chatBotDiary',
      () async {
        // act
        final stream = repo.watchAllOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<Question>>(
            listOf(questionDay, questionSleep),
          )),
        );
      },
    );
  });
}
