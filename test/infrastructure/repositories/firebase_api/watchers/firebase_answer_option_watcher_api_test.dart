// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_answer_option_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/answer_options_diary.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/chatbots/politics/answer_options_politics.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseAnswerOptionWatcherApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();

    repo = FireBaseAnswerOptionWatcherApi(fs);

    // arrange

    // ChatBot: Diary
    // Question: How way your day?
    await fs.populateWithAnswerOption(answerOptionDayGood);
    await fs.populateWithAnswerOption(answerOptionDayBad);
    // ChatBot: Diary
    // Question: What did you do today?
    await fs.populateWithAnswerOption(answerOptionActivityWorking);
    await fs.populateWithAnswerOption(answerOptionActivityFriends);
    // ChatBot: Politics
    // Question: What do you want to vote?
    await fs.populateWithAnswerOption(answerOptionVoteSPD);
    await fs.populateWithAnswerOption(answerOptionVoteCDU);
  });

  group('watchOne()', () {
    test(
      'should stream a list containing only answerOptionDayGood',
      () async {
        // act
        final stream = repo.watchOne(answerOptionDayGood.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<AnswerOption>>(
              listOf(answerOptionDayGood))),
        );
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
          emits(
            left<CrudFailure, KtList<AnswerOption>>(
                const CrudFailure.doesNotExist()),
          ),
        );
      },
    );
  });
  group('watchAllOfQuestion()', () {
    test(
      'should stream a list containing only answerOptions of questionDay',
      () async {
        // act
        final stream = repo.watchAllOfQuestion(questionDay.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<AnswerOption>>(
              listOf(answerOptionDayGood, answerOptionDayBad))),
        );
      },
    );
  });
  group('watchAllOfOfChatBot()', () {
    test(
      'should stream a list containing only answerOptions of chatBotDiary',
      () async {
        // act
        final stream = repo.watchAllOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          stream,
          emits(right<CrudFailure, KtList<AnswerOption>>(listOf(
            answerOptionDayGood,
            answerOptionDayBad,
            answerOptionActivityWorking,
            answerOptionActivityFriends,
          ))),
        );
      },
    );
  });
}
