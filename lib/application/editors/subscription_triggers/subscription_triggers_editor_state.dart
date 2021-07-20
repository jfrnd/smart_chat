part of 'subscription_triggers_editor_cubit.dart';

@freezed
class SubscriptionTriggersEditorState with _$SubscriptionTriggersEditorState {
  const factory SubscriptionTriggersEditorState({
    required KtList<SubscriptionTrigger> triggers,
    required SubscriptionTime tempTime,
  }) = _SubscriptionTriggersEditorState;

  factory SubscriptionTriggersEditorState.initial(KtList<SubscriptionTrigger> triggers) =>
      SubscriptionTriggersEditorState(
        triggers: triggers,
        tempTime: SubscriptionTime.empty(),
      );
}
