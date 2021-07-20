part of 'qar_selector_bloc.dart';

@freezed
class QarSelectorState with _$QarSelectorState {
  const factory QarSelectorState({
    required Qar? selectedQar,
    required Question question,
    required KtList<AnswerOption> answerOptions,
    required KtList<AnswerItemValue> possibleItemValues,
    required KtList<AnswerItem> savedAnswerItems,
  }) = _QarSelectorState;

  factory QarSelectorState.initial() => QarSelectorState(
        question: Question.empty(),
        selectedQar: null,
        answerOptions: listOf(),
        possibleItemValues: listOf(),
        savedAnswerItems: listOf(),
      );
}
