// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';

part 'subscription_triggers_editor_state.dart';
part 'subscription_triggers_editor_cubit.freezed.dart';

class SubscriptionTriggersEditorCubit
    extends Cubit<SubscriptionTriggersEditorState> {
  final ChatBotEditorCubit editorCubit;

  SubscriptionTriggersEditorCubit(this.editorCubit)
      : super(SubscriptionTriggersEditorState.initial(
            editorCubit.state.entity!.triggers));

  void timeValueChanged(
    int index,
  ) {
    emit(
      state.copyWith(
        triggers: state.triggers.mapIndexed(
          (idx, item) => index != idx
              ? item
              : SubscriptionTrigger(
                  frequency: item.value.first,
                  time: state.tempTime,
                ),
        ),
      ),
    );
  }

  void dayValueChanged(
    int index,
    SubscriptionFrequency frequency,
  ) {
    emit(
      state.copyWith(
        triggers: state.triggers.mapIndexed(
          (idx, item) => index != idx
              ? item
              : SubscriptionTrigger(
                  frequency: frequency,
                  time: item.value.second,
                ),
        ),
      ),
    );
  }

  void itemDeleted(
    int index,
  ) {
    emit(
      state.copyWith(
          triggers:
              state.triggers.minusElement(state.triggers.elementAt(index))),
    );
  }

  void tempTimeValueChanged(
    SubscriptionTime time,
  ) {
    emit(
      state.copyWith(tempTime: time),
    );
  }

  void tempTimeValueReset(
    int index,
  ) {
    emit(
      state.copyWith(tempTime: state.triggers[index].value.second),
    );
  }

  void triggerAdded() {
    emit(
      state.copyWith(
        triggers: state.triggers.plusElement(
          SubscriptionTrigger(
            frequency: SubscriptionFrequency.daily(),
            time: SubscriptionTime(hh: 18),
          ),
        ),
      ),
    );
  }

  void saved() => editorCubit.triggersChanged(
        triggers: state.triggers,
      );
}
