part of 'multiple_choice_picker_cubit.dart';

@freezed
class MultipleChoicePickerState with _$MultipleChoicePickerState {
  const factory MultipleChoicePickerState({
    required bool showAddNewAnswerOptionChip,
    required KtList<AnswerItemValue> displayedItemValues,
    required KtList<AnswerItemValue> selectedItemValues,
    required String textInput,
    required LanguageCode languageCode,
    required bool multiSelection,
    required ValueFailure? textInputFailure,
  }) = _MultipleChoicePickerState;

  factory MultipleChoicePickerState.initial() => MultipleChoicePickerState(
        showAddNewAnswerOptionChip: false,
        displayedItemValues: listOf(),
        selectedItemValues: listOf(),
        textInput: '',
        languageCode: LanguageCode.en(),
        multiSelection: false,
        textInputFailure: null,
      );
}
