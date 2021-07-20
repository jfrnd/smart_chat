// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/answer_items_diary.dart';
import '../../fixtures/chatbots/diary/answer_options_diary.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../fixtures/chatbots/diary/qars_diary.dart';
import '../../fixtures/chatbots/diary/questions_diary.dart';

class MockIChatBotWatcherApi extends Mock implements IChatBotWatcherApi {}

class MockIQuestionWatcherApi extends Mock implements IQuestionWatcherApi {}

class MockIQarWatcherApi extends Mock implements IQarWatcherApi {}

class MockIAnswerItemWatcherApi extends Mock implements IAnswerItemWatcherApi {}

class MockIAnswerOptionWatcherApi extends Mock
    implements IAnswerOptionWatcherApi {}

class MockIQarCrudRepo extends Mock implements IQarCrudRepo {}

class MockIAuthFacade extends Mock implements IAuthFacade {}

void main() {
  late MockIChatBotWatcherApi chatBotWatcherApi;
  late MockIQuestionWatcherApi questionWatcherApi;
  late MockIQarWatcherApi qarWatcherRepo;
  late MockIAnswerItemWatcherApi answerItemWatcherApi;
  late MockIAnswerOptionWatcherApi answerOptionWatcherApi;
  late MockIQarCrudRepo qarCrudRepo;
  late MockIAuthFacade authFacade;

  late ChatWatcherBloc bloc;

  setUp(() {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    registerFallbackValue<UniqueId>(UniqueId());
    registerFallbackValue<Question>(Question.empty());
    registerFallbackValue<Qar>(Qar.empty());
    registerFallbackValue<AnswerItem>(AnswerItem.empty());
    registerFallbackValue<AnswerOption>(AnswerOption.empty());

    chatBotWatcherApi = MockIChatBotWatcherApi();
    questionWatcherApi = MockIQuestionWatcherApi();
    qarWatcherRepo = MockIQarWatcherApi();
    answerItemWatcherApi = MockIAnswerItemWatcherApi();
    answerOptionWatcherApi = MockIAnswerOptionWatcherApi();
    qarCrudRepo = MockIQarCrudRepo();
    authFacade = MockIAuthFacade();
    bloc = ChatWatcherBloc(
        chatBotRepo: chatBotWatcherApi,
        questionRepo: questionWatcherApi,
        qarCrudRepo: qarCrudRepo,
        qarRepoWatcher: qarWatcherRepo,
        answerItemRepo: answerItemWatcherApi,
        answerOptionRepo: answerOptionWatcherApi,
        authFacade: authFacade);

    when(() => chatBotWatcherApi.watchOne(any()))
        .thenAnswer((_) => Stream.value(right(listOf(chatBotDiary))));
    when(() => questionWatcherApi.watchAllOfChatBot(any()))
        .thenAnswer((_) => Stream.value(right(listOf(questionDay))));
    when(() => answerOptionWatcherApi.watchAllOfChatBot(any()))
        .thenAnswer((_) => Stream.value(right(listOf(answerOptionDayGood))));
    when(() => answerItemWatcherApi.watchAllOfChatBotAndSignedInUser(any()))
        .thenAnswer(
            (_) => Stream.value(right(listOf(answerItemDayGoodMonday))));
    when(() => qarWatcherRepo.watchAllVisibleOfChatBot(any()))
        .thenAnswer((_) => Stream.value(right(listOf(qarDayMonday))));
  });

  tearDown(() async {
    bloc.close();
    reset(chatBotWatcherApi);
    reset(questionWatcherApi);
    reset(qarWatcherRepo);
    reset(answerItemWatcherApi);
    reset(answerOptionWatcherApi);
  });

  group('watchStarted() - Not Successful', () {
    blocTest('''should emit:
      [isLoading: true],
      [isLoading: false, failure: CrudFailure]
       when chatBotRepo.watchOne() is not successful
       ''',
        build: () {
          when(() => chatBotWatcherApi.watchOne(any())).thenAnswer(
              (_) => Stream.value(left(const CrudFailure.unexpected())));
          return bloc;
        },
        act: (_) =>
            bloc.add(ChatWatcherEvent.watchStarted(chatBotId: chatBotDiary.id)),
        expect: () => [
              bloc.state.copyWith(isLoading: true, failure: null),
              bloc.state.copyWith(
                  isLoading: false, failure: const CrudFailure.unexpected()),
            ],
        verify: (_) {
          verify(() => chatBotWatcherApi.watchOne(any()));
          verify(() => questionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(
              () => answerOptionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(() => answerItemWatcherApi
              .watchAllOfChatBotAndSignedInUser(chatBotDiary.id));
          verify(
              () => qarWatcherRepo.watchAllVisibleOfChatBot(chatBotDiary.id));
        });

    blocTest('''should emit:
      [isLoading: true],
      [isLoading: false, failure: CrudFailure]
       when questionRepo.watchOne() is not successful
       ''',
        build: () {
          when(() => questionWatcherApi.watchAllOfChatBot(any())).thenAnswer(
              (_) => Stream.value(left(const CrudFailure.unexpected())));
          return bloc;
        },
        act: (_) =>
            bloc.add(ChatWatcherEvent.watchStarted(chatBotId: chatBotDiary.id)),
        expect: () => [
              bloc.state.copyWith(isLoading: true, failure: null),
              bloc.state.copyWith(
                  isLoading: false, failure: const CrudFailure.unexpected()),
            ],
        verify: (_) {
          verify(() => chatBotWatcherApi.watchOne(chatBotDiary.id));
          verify(() => questionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(
              () => answerOptionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(() => answerItemWatcherApi
              .watchAllOfChatBotAndSignedInUser(chatBotDiary.id));
          verify(
              () => qarWatcherRepo.watchAllVisibleOfChatBot(chatBotDiary.id));
        });

    blocTest('''should emit:
      [isLoading: true],
      [isLoading: false, failure: CrudFailure]
       when qar.watchAllOf() is not successful
       ''',
        build: () {
          when(() => qarWatcherRepo.watchAllVisibleOfChatBot(any())).thenAnswer(
              (_) => Stream.value(left(const CrudFailure.unexpected())));
          return bloc;
        },
        act: (_) =>
            bloc.add(ChatWatcherEvent.watchStarted(chatBotId: chatBotDiary.id)),
        expect: () => [
              bloc.state.copyWith(isLoading: true, failure: null),
              bloc.state.copyWith(
                  isLoading: false, failure: const CrudFailure.unexpected()),
            ],
        verify: (_) {
          verify(() => chatBotWatcherApi.watchOne(chatBotDiary.id));
          verify(() => questionWatcherApi.watchAllOfChatBot(chatBotDiary.id));

          verify(
              () => answerOptionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(() => answerItemWatcherApi
              .watchAllOfChatBotAndSignedInUser(chatBotDiary.id));
          verify(
              () => qarWatcherRepo.watchAllVisibleOfChatBot(chatBotDiary.id));
        });

    blocTest('''should emit:
      [isLoading: true],
      [isLoading: false, failure: CrudFailure]
       when answerOptionRepo.watchAllOfChatBot() is not successful
       ''',
        build: () {
          when(() => answerOptionWatcherApi.watchAllOfChatBot(any()))
              .thenAnswer(
                  (_) => Stream.value(left(const CrudFailure.unexpected())));
          return bloc;
        },
        act: (_) =>
            bloc.add(ChatWatcherEvent.watchStarted(chatBotId: chatBotDiary.id)),
        expect: () => [
              bloc.state.copyWith(isLoading: true, failure: null),
              bloc.state.copyWith(
                  isLoading: false, failure: const CrudFailure.unexpected()),
            ],
        verify: (_) {
          verify(() => chatBotWatcherApi.watchOne(chatBotDiary.id));
          verify(() => questionWatcherApi.watchAllOfChatBot(chatBotDiary.id));

          verify(
              () => answerOptionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(() => answerItemWatcherApi
              .watchAllOfChatBotAndSignedInUser(chatBotDiary.id));
          verify(
              () => qarWatcherRepo.watchAllVisibleOfChatBot(chatBotDiary.id));
        });

    blocTest('''should emit:
      [isLoading: true],
      [isLoading: false, failure: CrudFailure]
       when answerItemRepo.watchOne() is not successful
       ''',
        build: () {
          when(() =>
                  answerItemWatcherApi.watchAllOfChatBotAndSignedInUser(any()))
              .thenAnswer(
                  (_) => Stream.value(left(const CrudFailure.unexpected())));
          return bloc;
        },
        act: (_) =>
            bloc.add(ChatWatcherEvent.watchStarted(chatBotId: chatBotDiary.id)),
        expect: () => [
              bloc.state.copyWith(isLoading: true, failure: null),
              bloc.state.copyWith(
                  isLoading: false, failure: const CrudFailure.unexpected()),
            ],
        verify: (_) {
          verify(() => chatBotWatcherApi.watchOne(chatBotDiary.id));
          verify(() => questionWatcherApi.watchAllOfChatBot(chatBotDiary.id));

          verify(
              () => answerOptionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(() => answerItemWatcherApi
              .watchAllOfChatBotAndSignedInUser(chatBotDiary.id));
          verify(
              () => qarWatcherRepo.watchAllVisibleOfChatBot(chatBotDiary.id));
        });
  });

  group('watchStarted() - Successful', () {
    blocTest('''should emit:
      [isLoading: true],
      [isLoading: false, failure: null, chatBot: chatBotDiary, questions: listOf(questionDay),
      answerOptions: listOf(answerOptionDayGood), answerItems: listOf(answerItemDayGood),
      qars: listOf(qarDay)
      ]
       when answerItemRepo.watchOne() is not successful
       ''',
        build: () {
          return bloc;
        },
        act: (_) =>
            bloc.add(ChatWatcherEvent.watchStarted(chatBotId: chatBotDiary.id)),
        expect: () => [
              bloc.state.copyWith(
                isLoading: true,
                failure: null,
                chatBot: ChatBot.empty(),
                questions: listOf(),
                answerOptions: listOf(),
                answerItems: listOf(),
                qars: listOf(),
              ),
              bloc.state.copyWith(
                isLoading: false,
                failure: null,
                chatBot: chatBotDiary,
                questions: listOf(questionDay),
                answerOptions: listOf(
                    answerOptionDayGood, AnswerOption.yes(), AnswerOption.no()),
                answerItems: listOf(answerItemDayGoodMonday),
                qars: listOf(qarDayMonday),
              ),
            ],
        verify: (_) {
          verify(() => chatBotWatcherApi.watchOne(chatBotDiary.id));
          verify(() => questionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(
              () => answerOptionWatcherApi.watchAllOfChatBot(chatBotDiary.id));
          verify(() => answerItemWatcherApi
              .watchAllOfChatBotAndSignedInUser(chatBotDiary.id));
          verify(
              () => qarWatcherRepo.watchAllVisibleOfChatBot(chatBotDiary.id));
        });
  });
}
