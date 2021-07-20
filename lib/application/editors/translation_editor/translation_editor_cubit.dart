// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';

part 'translation_editor_state.dart';
part 'translation_editor_cubit.freezed.dart';

class TranslationEditorCubit<T extends TranslatableEntity,
    V extends StringValueObject> extends Cubit<TranslationEditorState<V>> {
  final EntityEditorCubit<T, V> editorCubit;

  TranslationEditorCubit(
      {required this.editorCubit, required LanguageCode selectedLanguageCode})
      : super(
          TranslationEditorState<V>.initial(
            selectedLanguageCode: selectedLanguageCode,
            initTranslation: editorCubit.state.entity!.translations
                .getValueObjectOrNull(selectedLanguageCode) as V?,
          ),
        );

  void translationChanged({
    required String input,
  }) {
    late V newTranslation;

    if (V == ChatBotName) {
      newTranslation = ChatBotName.genericCreate(input: input) as V;
    }
    if (V == QuestionBody) {
      newTranslation = QuestionBody.genericCreate(input: input) as V;
    }
    if (V == AnswerOptionBody) {
      newTranslation = AnswerOptionBody.genericCreate(input: input) as V;
    }

    emit(
      state.copyWith(
        translation: newTranslation,
      ),
    );
  }

  void saved() {
    emit(state.copyWith(showErrorMessages: true));
    if (state.translation?.isValid() ?? false) {
      editorCubit.translationChanged(
        languageCode: state.selectedLanguageCode,
        input: state.translation!,
      );

      emit(state.copyWith(saved: true));
    }
  }
}
