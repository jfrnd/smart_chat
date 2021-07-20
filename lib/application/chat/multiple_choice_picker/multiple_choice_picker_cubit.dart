// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';

part 'multiple_choice_picker_cubit.freezed.dart';
part 'multiple_choice_picker_state.dart';

class MultipleChoicePickerCubit extends Cubit<MultipleChoicePickerState> {
  final QarSelectorBloc qarSelectorBloc;
  final ChatActorBloc chatActorBloc;
  final SettingsBloc settingsBloc;

  StreamSubscription? qarSelectorBlocSubscription;

  MultipleChoicePickerCubit({
    required this.qarSelectorBloc,
    required this.chatActorBloc,
    required this.settingsBloc,
  }) : super(MultipleChoicePickerState.initial()) {
    qarSelectorBlocSubscription =
        qarSelectorBloc.stream.startWith(qarSelectorBloc.state).listen(
      (state) {
        updateState(qarSelectorState: state);
      },
    );
  }

  @override
  Future<void> close() {
    qarSelectorBlocSubscription?.cancel();
    return super.close();
  }

  void curTextInputChanged(String input) {
    if (state.multiSelection == false) {
      emit(
        state.copyWith(
          selectedItemValues: emptyList(),
          displayedItemValues: qarSelectorBloc.state.possibleItemValues,
        ),
      );
    }

    updateState(
      qarSelectorState: qarSelectorBloc.state,
      newTextInput: input,
    );
  }

  void answerUnselected(AnswerItemValue answer) {
    emit(
      state.copyWith(
        selectedItemValues: state.selectedItemValues.minusElement(answer),
        displayedItemValues: state.displayedItemValues.plusElement(answer),
      ),
    );
  }

  void answerSelected(AnswerItemValue answer) {
    if (state.multiSelection) {
      emit(
        state.copyWith(
          selectedItemValues: state.selectedItemValues.plusElement(answer),
          displayedItemValues: state.displayedItemValues.minusElement(answer),
        ),
      );
    } else {
      emit(
        state.copyWith(
          displayedItemValues: state.displayedItemValues
              .minusElement(answer)
              .plus(state.selectedItemValues),
          selectedItemValues: state.selectedItemValues
              .plusElement(answer)
              .minus(state.selectedItemValues),
        ),
      );
    }
    updateState(qarSelectorState: qarSelectorBloc.state, newTextInput: '');
  }

  Future<void> saved() async {
    KtList<AnswerItemValue> newAnswerItemValue = emptyList();

    if (state.textInput.isNotEmpty) {
      await _answerOptionCreated().then(
        (unitOrAnswerOption) => unitOrAnswerOption.fold(
          (_) => null,
          (answerOption) => newAnswerItemValue = listOf(
            AnswerItemValue.fromAnswerOptionId(answerOption.id),
          ),
        ),
      );
    }

    chatActorBloc.add(
      ChatActorEvent.answerItemsCreated(
        itemValues: state.selectedItemValues + newAnswerItemValue,
        qar: qarSelectorBloc.state.selectedQar!,
      ),
    );

    emit(
      state.copyWith(
        showAddNewAnswerOptionChip: false,
        selectedItemValues: listOf(),
        textInput: '',
        displayedItemValues: listOf(),
      ),
    );
  }

  void onNewAnswerOptionClicked() {
    _answerOptionCreated().then(
      (unitOrAnswerOption) => unitOrAnswerOption.fold(
        (_) => null,
        (answerOption) => answerSelected(
          AnswerItemValue.fromAnswerOptionId(answerOption.id),
        ),
      ),
    );
  }

  Future<Either<Unit, AnswerOption>> _answerOptionCreated() async {
    final body = AnswerOptionBody(state.textInput);

    emit(
      state.copyWith(
        textInputFailure: null,
      ),
    );

    return body.getFailureOrUnit().fold(
      (failure) {
        emit(
          state.copyWith(
            textInputFailure: failure,
          ),
        );
        return const Left(unit);
      },
      (unit) {
        return chatActorBloc
            .answerOptionCreated(
              qarSelectorBloc.state.selectedQar!,
              state.languageCode,
              body,
            )
            .then(
              (unitOrAnswerOption) => unitOrAnswerOption.fold(
                (_) => Left(unit),
                (newAnswerOption) => Right(newAnswerOption),
              ),
            );
      },
    );
  }

  void updateState({
    required QarSelectorState qarSelectorState,
    String? newTextInput,
  }) {
    if (qarSelectorState.question.type is MultipleChoice) {
      final languageCode = LanguageCode.fromLocale(
          settingsBloc.state.appLocale ?? const Locale('en'));

      final textInput = newTextInput ?? state.textInput;

      final displayedItemValues = qarSelectorState.possibleItemValues
          .minus(state.selectedItemValues)
          .filterTextInput(
            textInput,
            qarSelectorState.answerOptions,
            languageCode,
          );

      final selectedItemValues = state.selectedItemValues.filter(
        (itemValue) => qarSelectorState.possibleItemValues.contains(itemValue),
      );

      emit(
        state.copyWith(
          textInput: newTextInput ?? '',
          languageCode: languageCode,
          showAddNewAnswerOptionChip: textInput.isNotEmpty &&
              qarSelectorState.answerOptions
                  .notContains(textInput, languageCode),
          displayedItemValues: displayedItemValues,
          selectedItemValues: selectedItemValues,
          multiSelection: qarSelectorState.question.multiSelection,
        ),
      );
    }
  }
}
