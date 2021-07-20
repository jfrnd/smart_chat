// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';

part 'question_min_max_editor_state.dart';
part 'question_min_max_editor_cubit.freezed.dart';

class QuestionMinMaxEditorCubit extends Cubit<QuestionMinMaxEditorState> {
  QuestionMinMaxEditorCubit(QuestionEditorCubit editorCubit)
      : super(QuestionMinMaxEditorState.initial()) {
    initialize(
      min: editorCubit.state.entity!.minVal.getOrCrash(),
      max: editorCubit.state.entity!.maxVal.getOrCrash(),
    );

    editorCubitStateStream =
        editorCubit.stream.startWith(editorCubit.state).listen(
      (state) {
        _minValueChanged(state.entity!.minVal.getOrCrash());
        _maxValueChanged(state.entity!.maxVal.getOrCrash());
      },
    );
  }

  StreamSubscription<EntityEditorState<Question>>? editorCubitStateStream;

  @override
  Future<void> close() async {
    await editorCubitStateStream?.cancel();
    return super.close();
  }

  void _maxValueChanged(double max) => emit(state.copyWith(max: max));
  void _minValueChanged(double min) => emit(state.copyWith(min: min));

  void initialize({required double min, required double max}) {
    _minMinValueChanged(min - 0.5 * (max - min));
    _minValueChanged(min);
    _maxValueChanged(max);
    _maxMaxValueChanged(max + 0.5 * (max - min));
  }

  void _maxMaxValueChanged(double maxMax) =>
      emit(state.copyWith(maxMax: (maxMax + 0.5).roundToDouble()));

  void _minMinValueChanged(double minMin) =>
      emit(state.copyWith(minMin: (minMin - 0.5).roundToDouble()));

  void updateMaxMax() {
    if (state.max > state.maxMax - 0.25 * (state.maxMax - state.minMin)) {
      _extendMaxMax();
    }
    if (state.max < state.maxMax - 0.25 * (state.maxMax - state.minMin)) {
      _decreaseMaxMax();
    }
  }

  void updateMinMin() {
    if (state.min < state.minMin + 0.25 * (state.maxMax - state.minMin)) {
      _extendMinMin();
    }
    if (state.min > state.minMin + 0.25 * (state.maxMax - state.minMin)) {
      _decreaseMinMin();
    }
  }

  void _extendMaxMax() {
    final newMaxMax = state.max + (state.maxMax - state.minMin) * 0.25;

    if (state.max < newMaxMax) {
      _maxMaxValueChanged(newMaxMax);
    }
  }

  void _extendMinMin() {
    final newMinMin = state.min - (state.maxMax - state.minMin) * 0.25;
    if (state.hasNegative) {
      _minMinValueChanged(newMinMin);
    } else {
      _minMinValueChanged(newMinMin < 0 ? 0 : newMinMin);
    }
  }

  void _decreaseMaxMax() {
    final newMaxMax = state.max + (state.maxMax - state.minMin) * 0.1;
    if (state.max < newMaxMax) {
      _maxMaxValueChanged(state.max + (state.maxMax - state.minMin) * 0.1);
    }
  }

  void _decreaseMinMin() {
    final newMinMin = state.min - (state.maxMax - state.minMin) * 0.1;
    if (state.hasNegative && state.min > newMinMin) {
      _minMinValueChanged(newMinMin);
    } else if (state.min > newMinMin) {
      _minMinValueChanged(newMinMin < 0 ? 0 : newMinMin);
    }
  }
}
