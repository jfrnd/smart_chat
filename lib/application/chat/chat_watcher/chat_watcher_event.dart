part of 'chat_watcher_bloc.dart';

@freezed
class ChatWatcherEvent with _$ChatWatcherEvent {
  const factory ChatWatcherEvent.watchStarted({required UniqueId chatBotId}) =
      _WatchStarted;
  const factory ChatWatcherEvent.failureReceived(CrudFailure failure) =
      _FailureReceived;
  const factory ChatWatcherEvent.dataReceived(
    ChatBot chatBot,
    KtList<Qar> qars,
    KtList<Question> questions,
    KtList<AnswerOption> answerOptions,
    KtList<AnswerItem> answerItems,
  ) = _DataReveived;
}
