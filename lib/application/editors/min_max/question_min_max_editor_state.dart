part of 'question_min_max_editor_cubit.dart';

@freezed
class QuestionMinMaxEditorState with _$QuestionMinMaxEditorState {
  const factory QuestionMinMaxEditorState({
    required double minMin,
    required double min,
    required double max,
    required double maxMax,
    required bool hasNegative,
  }) = _QuestionMinMaxEditorState;

  factory QuestionMinMaxEditorState.initial() =>
      const QuestionMinMaxEditorState(
        minMin: -99999,
        min: 30.0,
        max: 60.0,
        maxMax: 99999,
        hasNegative: true,
      );
}
