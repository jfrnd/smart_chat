part of 'chat_actor_bloc.dart';

@freezed
class ChatActorState with _$ChatActorState {
  const factory ChatActorState({
    required bool isSaving,
    required CrudFailure? failure,
  }) = _ChatActorState;

  factory ChatActorState.initial() => const ChatActorState(
        isSaving: false,
        failure: null,
      );
}
