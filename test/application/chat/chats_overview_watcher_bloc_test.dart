// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/chat/chats_overview_watcher/chats_overview_watcher_bloc.dart';

// Project imports:
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

class MockIChatBotRepoWatcher extends Mock implements IChatBotWatcherApi {}

class MockIQarRepoWatcher extends Mock implements IQarWatcherApi {}

class MockIAuthRepo extends Mock implements IAuthRepo {}

class MockIAnswerItemCrudRepo extends Mock implements IAnswerItemCrudRepo {}

class MockIAnswerOptionCrudRepo extends Mock implements IAnswerOptionCrudRepo {}

class MockSettingsBloc extends Mock implements SettingsBloc {}

class MockIQuestionCrudRepo extends Mock implements IQuestionCrudRepo {}

void main() {
  late MockIChatBotRepoWatcher chatBotRepo;
  late MockIQarRepoWatcher qarRepoWatcher;
  late MockIAuthRepo authRepo;
  late MockIAnswerOptionCrudRepo answerOptionRepoCrud;
  late MockIAnswerItemCrudRepo answerItemRepoCrud;
  late MockIQuestionCrudRepo questionRepoCrud;

  late MockSettingsBloc settingsBloc;

  late ChatsOverviewWatcherBloc bloc;

  setUp(() {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    registerFallbackValue<UniqueId>(UniqueId());
    registerFallbackValue<Question>(Question.empty());
    registerFallbackValue<Qar>(Qar.empty());
    registerFallbackValue<AnswerItem>(AnswerItem.empty());
    registerFallbackValue<AnswerOption>(AnswerOption.empty());

    chatBotRepo = MockIChatBotRepoWatcher();
    qarRepoWatcher = MockIQarRepoWatcher();
    authRepo = MockIAuthRepo();
    settingsBloc = MockSettingsBloc();
    answerOptionRepoCrud = MockIAnswerOptionCrudRepo();
    answerItemRepoCrud = MockIAnswerItemCrudRepo();
    questionRepoCrud = MockIQuestionCrudRepo();
    bloc = ChatsOverviewWatcherBloc(
      chatBotWatcher: chatBotRepo,
      authRepo: authRepo,
      qarRepoWatcher: qarRepoWatcher,
      answerItemRepoCrud: answerItemRepoCrud,
      answerOptionRepoCrud: answerOptionRepoCrud,
      settingsBloc: settingsBloc,
      questionRepoCrud: questionRepoCrud,
    );
  });

  tearDown(() async {
    bloc.close();
    reset(chatBotRepo);
    reset(qarRepoWatcher);
  });

  group('watchStarted()', () {
//TODO watchStarted()
  });
  group('chatBotsReceived()', () {
//TODO chatBotsReceived()
  });
  group('failureReceived()', () {
//TODO failureReceived()
  });
  group('qarsReceived()', () {
//TODO qarsReceived()
  });
}
