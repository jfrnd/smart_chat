part of 'chat_watcher_bloc.dart';

@freezed
class ChatWatcherState with _$ChatWatcherState {
  const factory ChatWatcherState({
    required bool isLoading,
    required CrudFailure? failure,
    required ChatBot chatBot,
    required KtList<Question> questions,
    required KtList<Qar> qars,
    required KtList<AnswerItem> answerItems,
    required KtList<AnswerOption> answerOptions,
  }) = _ChatWatcherState;

  factory ChatWatcherState.initial() => ChatWatcherState(
        isLoading: true,
        failure: null,
        chatBot: ChatBot.empty(),
        questions: listOf(),
        qars: listOf(),
        answerItems: listOf(),
        answerOptions: listOf(),
      );
}
