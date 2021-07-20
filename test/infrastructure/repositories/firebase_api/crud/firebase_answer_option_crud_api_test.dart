// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_answer_option_crud_api.dart';
import '../../../../fixtures/chatbots/diary/answer_options_diary.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/diary/questions_diary.dart';
import '../../../../fixtures/chatbots/politics/answer_options_politics.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseAnswerOptionCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();

    repo = FireBaseAnswerOptionCrudApi(fs);

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

  group('readOne()', () {
    test(
      'should return answerOptionDayGood',
      () async {
        // act
        final result = await repo.readOne(answerOptionDayGood.id);
        // assert
        expectLater(
          result,
          equals(right<CrudFailure, AnswerOption>(answerOptionDayGood)),
        );
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
  group('readAllOfQuestion()', () {
    test(
      'should return a list containing only answerOptions of questionDay',
      () async {
        // act
        final result = await repo.readAllOfQuestion(questionDay.id);
        // assert
        expectLater(
          result,
          equals(right<CrudFailure, KtList<AnswerOption>>(
              listOf(answerOptionDayGood, answerOptionDayBad))),
        );
      },
    );
  });
  group('readAllOfChatBot()', () {
    test(
      'should return a list containing only answerOptions of chatBotDiary',
      () async {
        // act
        final result = await repo.readAllOfChatBot(chatBotDiary.id);
        // assert
        expectLater(
          result,
          equals(right<CrudFailure, KtList<AnswerOption>>(listOf(
              answerOptionDayGood,
              answerOptionDayBad,
              answerOptionActivityWorking,
              answerOptionActivityFriends))),
        );
      },
    );
  });
  group('createOnDB()', () {
    test(
      'should add answerOption to fs and return right(unit)',
      () async {
        // act
        final response = await repo.createOnDB(answerOptionActivitySoccer);
        // assert

        final answerOptionOnFs = await fs.getAnswerOptionOrNull(
          chatBotId: answerOptionActivitySoccer.chatBotId,
          questionId: answerOptionActivitySoccer.questionId,
          answerOptionId: answerOptionActivitySoccer.id,
        );

        expectLater(answerOptionOnFs, equals(answerOptionActivitySoccer));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('updateOnDB', () {
    test(
      'should update answerOption on fs and return right(unit)',
      () async {
        // act
        final updatedAnswerOptionBodyDayGoodEN = AnswerOptionBody('very good');
        final updatedAnswerOptionBodyDayGoodDE = AnswerOptionBody('sehr gut');
        final updatedAnswerOptionBodyLangMap =
            Translatable<AnswerOptionBody>(KtMap.from({
          LanguageCode.en(): updatedAnswerOptionBodyDayGoodEN,
          LanguageCode.de(): updatedAnswerOptionBodyDayGoodDE
        }));
        final updatedDomainAnswerOption = answerOptionDayGood.copyWith(
            translations: updatedAnswerOptionBodyLangMap);

        final response = await repo.updateOnDB(updatedDomainAnswerOption);
        // assert

        final updatedAnswerOptionOnFs = await fs.getAnswerOptionOrNull(
          chatBotId: answerOptionDayGood.chatBotId,
          questionId: answerOptionDayGood.questionId,
          answerOptionId: answerOptionDayGood.id,
        );

        expectLater(updatedAnswerOptionOnFs, equals(updatedDomainAnswerOption));
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('deleteFromDB', () {
    test(
      'should delete answerOption from fs and return right(unit)',
      () async {
        // act
        final response = await repo.deleteFromDB(answerOptionDayGood);
        // assert

        final doc = await fs.getAnswerOptionOrNull(
          chatBotId: answerOptionDayGood.chatBotId,
          questionId: answerOptionDayGood.questionId,
          answerOptionId: answerOptionDayGood.id,
        );

        final doc2 = await fs.getAnswerOptionOrNull(
          chatBotId: answerOptionDayBad.chatBotId,
          questionId: answerOptionDayBad.questionId,
          answerOptionId: answerOptionDayBad.id,
        );

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
}
