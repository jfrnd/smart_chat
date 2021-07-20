// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:matcher/matcher.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_chatbot_crud_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/chatbots/fitness/chatbot_fitness.dart';
import '../../../../fixtures/chatbots/politics/chatbot_politics.dart';
import '../../../../fixtures/chatbots/survey/chatbot_survey.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseChatBotCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseChatBotCrudApi(fs);

    await fs.populateWithChatBot(chatBotDiary);
    await fs.populateWithChatBot(chatBotFitness);
    await fs.populateWithChatBot(chatBotPolitics); //user 2
  });

  group('readOne()', () {
    test(
      'should return chatBotDiary',
      () async {
        // act
        final res = await repo.readOne(chatBotDiary.id);
        // assert
        expectLater(res, right<CrudFailure, ChatBot>(chatBotDiary));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readOne(UniqueId());
        // assert
        expectLater(
            res, left<CrudFailure, ChatBot>(const CrudFailure.doesNotExist()));
      },
    );
  });
  group('readAllCreatedBy()', () {
    test(
      'should return a list containing only the chatBots of one user',
      () async {
        // act
        final res = await repo.readAllCreatedBy(dummyUserOne.id);
        // assert
        expectLater(
            res,
            right<CrudFailure, KtList<ChatBot>>(
                listOf(chatBotDiary, chatBotFitness)));
      },
    );
  });
  group('createOnDB()', () {
    test(
      '''should add chatBot to fs and return right(unit)''',
      () async {
        // act
        final response = await repo.createOnDB(chatBotSurvey);
        // assert
        final chatBotOnFs = await fs.getChatBotOrNull(chatBotSurvey.id);
        expectLater(response, equals(const Right(unit)));
        expectLater(chatBotOnFs, equals(chatBotSurvey));
      },
    );
  });
  group('updateOnDB()', () {
    test(
      'should update chatbot on fs and return right(unit)',
      () async {
        // arrange
        final updatedDomainChatBot = chatBotDiary.copyWith(
          translations: chatBotNameLangMapDiaryExtended,
        );
        // act
        final response = await repo.updateOnDB(updatedDomainChatBot);
        // assert
        final updatedChatBotOnFs = await fs.getChatBotOrNull(chatBotDiary.id);

        expectLater(response, equals(const Right(unit)));
        expectLater(updatedChatBotOnFs, equals(updatedDomainChatBot));
      },
    );
  });
  group('deleteFromDB()', () {
    test(
      'should delete chatBot from fs and return right(unit)',
      () async {
        // act
        final response = await repo.deleteFromDB(chatBotDiary);

        // assert

        final doc = await fs.getChatBotOrNull(chatBotDiary.id);
        final doc2 = await fs.getChatBotOrNull(chatBotFitness.id);

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
}
