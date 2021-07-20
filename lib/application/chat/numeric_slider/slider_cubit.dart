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
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';

part 'slider_state.dart';
part 'slider_cubit.freezed.dart';

class SliderCubit extends Cubit<SliderState> {
  final ChatActorBloc chatActorBloc;
  final QarSelectorBloc qarSelectorBloc;

  StreamSubscription? qarSelectorBlocSubscription;

  SliderCubit({
    required this.chatActorBloc,
    required this.qarSelectorBloc,
  }) : super(SliderState.initial()) {
    qarSelectorBlocSubscription =
        qarSelectorBloc.stream.startWith(qarSelectorBloc.state).listen((state) {
      if (state.question.type is Numeric) setInitValue(state);
    });
  }
  @override
  Future<void> close() async {
    await qarSelectorBlocSubscription?.cancel();
    return super.close();
  }

  void setInitValue(QarSelectorState selectorState) {
    final minVal = selectorState.question.minVal;
    final maxVal = selectorState.question.maxVal;
    final unit = selectorState.question.unit;

    setMinMaxUnit(minVal.getOrCrash(), maxVal.getOrCrash(), unit);

    AnswerItemValue? initValue =
        selectorState.savedAnswerItems.firstOrNull()?.value;
    initValue ??= selectorState.possibleItemValues.firstOrNull();
    if (initValue != null) {
      valueChanged(double.parse(initValue.getOrCrash()));
    } else {
      valueChanged(minVal.getOrCrash());
    }
  }

  void valueChanged(double val) => emit(state.copyWith(value: val));

  void valueIncrementedSmallStep() => state.value + 0.1 <= state.maxValue
      ? emit(state.copyWith(value: state.value + 0.1))
      : null;
  void valueDecrementedSmallStep() => state.value - 0.1 >= state.minValue
      ? emit(state.copyWith(value: state.value - 0.1))
      : null;
  void valueIncrementedNormalStep() => state.value + 1 <= state.maxValue
      ? emit(state.copyWith(value: state.value + 1))
      : null;
  void valueDecrementedNormalStep() => state.value - 1 >= state.minValue
      ? emit(state.copyWith(value: state.value - 1))
      : null;

  void setMinMaxUnit(double minVal, double maxVal, MUnit unit) {
    emit(state.copyWith(
      minValue: minVal,
      maxValue: maxVal,
      unit: unit,
    ));
  }

  void saved() {
    final itemValue =
        AnswerItemValue.fromString(state.value.toStringAsFixed(1));
    chatActorBloc.add(ChatActorEvent.answerItemsCreated(
      qar: qarSelectorBloc.state.selectedQar!,
      itemValues: listOf(itemValue),
    ));
  }
}
