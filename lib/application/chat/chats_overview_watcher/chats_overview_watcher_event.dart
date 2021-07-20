part of 'chats_overview_watcher_bloc.dart';

@freezed
class ChatsOverviewWatcherEvent with _$ChatsOverviewWatcherEvent {
  const factory ChatsOverviewWatcherEvent.watchStarted() = _WatchStarted;
  const factory ChatsOverviewWatcherEvent.failureReceived(CrudFailure failure) =
      _FailureReceived;
  const factory ChatsOverviewWatcherEvent.chatBotsReceived(KtList<ChatBot> chatBots) =
      _ChatBotsReceived;
  const factory ChatsOverviewWatcherEvent.qarsReceived(
    KtMap<UniqueId, Either<CrudFailure, Qar?>> idsToQars,
  ) = _QarsReceived;
}
