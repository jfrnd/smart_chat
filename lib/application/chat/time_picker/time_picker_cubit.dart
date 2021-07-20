// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';

part 'time_picker_cubit.freezed.dart';
part 'time_picker_state.dart';

class TimePickerCubit extends Cubit<TimePickerState> {
  final ChatActorBloc chatActorBloc;
  final QarSelectorBloc qarSelectorBloc;

  StreamSubscription? qarSelectorBlocSubscription;

  TimePickerCubit({
    required this.chatActorBloc,
    required this.qarSelectorBloc,
  }) : super(TimePickerState.initial()) {
    qarSelectorBlocSubscription =
        qarSelectorBloc.stream.startWith(qarSelectorBloc.state).listen((state) {
      if (state.question.type is Time) setInitValue(state);
    });
  }
  @override
  Future<void> close() async {
    await qarSelectorBlocSubscription?.cancel();
    return super.close();
  }

  void setInitValue(QarSelectorState selectorState) {
    AnswerItemValue? initValue =
        selectorState.savedAnswerItems.firstOrNull()?.value;
    initValue ??= selectorState.possibleItemValues.firstOrNull();
    if (initValue != null) {
      allChanged(TimeValue.fromItemValue(initValue));
    }
  }

  void allChanged(TimeValue value) {
    emit(state.copyWith(hh: value.hh));
    emit(state.copyWith(mm: value.mm));
    emit(state.copyWith(ss: value.ss));
  }

  void hhChanged(int hh) => emit(state.copyWith(hh: hh));
  void mmChanged(int mm) => emit(state.copyWith(mm: mm));
  void ssChanged(int ss) => emit(state.copyWith(ss: ss));

  void saved() {
    final timeValue = TimeValue(hh: state.hh, mm: state.mm, ss: state.ss);
    final itemValue = AnswerItemValue.fromTimeValue(timeValue);
    chatActorBloc.add(ChatActorEvent.answerItemsCreated(
      itemValues: listOf(itemValue),
      qar: qarSelectorBloc.state.selectedQar!,
    ));
  }
}
