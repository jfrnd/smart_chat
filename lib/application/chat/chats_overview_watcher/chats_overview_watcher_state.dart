part of 'chats_overview_watcher_bloc.dart';

@freezed
class ChatsOverviewWatcherState with _$ChatsOverviewWatcherState {
  const factory ChatsOverviewWatcherState({
    required bool isLoading,
    required CrudFailure? failure,
    required KtList<ChatBot> chatBots,
    required KtMap<UniqueId, String?> lastMessages,
    required KtMap<UniqueId, bool?> isAnswered,
    required KtMap<UniqueId, DateTime?> dateTime,
  }) = _ChatsOverviewWatcherState;

  factory ChatsOverviewWatcherState.initial() => ChatsOverviewWatcherState(
        isLoading: true,
        failure: null,
        chatBots: listOf(),
        isAnswered: const KtMap.empty(),
        lastMessages: const KtMap.empty(),
        dateTime: const KtMap.empty(),
      );
}
