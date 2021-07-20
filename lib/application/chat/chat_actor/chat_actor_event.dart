part of 'chat_actor_bloc.dart';

@freezed
class ChatActorEvent with _$ChatActorEvent {
  // const factory ChatActorEvent.answerItemSaved({
  //   required AnswerItemValue itemValue,
  //   required Qar qar,
  // }) = _AnswerItemSaved;
  // const factory ChatActorEvent.answerItemsAdded({
  //   required KtList<AnswerItemValue> itemValues,
  //   required Qar qar,
  // }) = _AnswerItemsAdded;
  const factory ChatActorEvent.answerItemDeleted({
    required UniqueId answerItemId,
  }) = _AnswerItemsDeleted;
  const factory ChatActorEvent.answerItemsCreated({
    required KtList<AnswerItemValue> itemValues,
    required Qar qar,
  }) = _AnswerItemsAdded;
  const factory ChatActorEvent.answerOptionCreatedStarted() =
      _AnswerOptionCreatedStarted;
  const factory ChatActorEvent.answerOptionCreatedFinished(
      {CrudFailure? failure}) = _AnswerOptionCreatedFinished;
}
