// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_chat/application/editors/translation_editor/translation_editor_cubit.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';
import 'package:smart_chat/utils/locale_extensions.dart';

class EditTranslationListTile<
    T extends TranslatableEntity,
    V extends StringValueObject,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  final V? translation;
  final LanguageCode languageCode;
  final bool showError;

  const EditTranslationListTile({
    Key? key,
    required this.translation,
    required this.languageCode,
    required this.showError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = T == ChatBot
        ? "Name"
        : T == Question
            ? "Question"
            : T == AnswerOption
                ? "Answer Option"
                : "";

    return InvertedListTile(
      onTap: () => showEditTextDialog<T, V, E>(
        context: context,
        languageCode: languageCode,
        initInput: translation?.getOrCrash() ?? "",
      ),
      leading: Text(
        languageCode.toLocale().toFlag(),
        style: const TextStyle(fontSize: 22),
      ),
      overline: languageCode.toLocale().toLanguage(context),
      body: translation?.getOrCrash() ?? "please enter a $label",
      onLongPress: () =>
          context.read<E>().translationDeleted(languageCode: languageCode),
      trailing: showError
          ? const Icon(
              Icons.warning,
              color: Colors.red,
            )
          : const Icon(Icons.edit),
    );
  }
}

Future<void> showEditTextDialog<T extends TranslatableEntity,
    V extends StringValueObject, E extends EntityEditorCubit<T, V>>({
  required BuildContext context,
  required LanguageCode languageCode,
  required String initInput,
}) {
  return showDialog(
    context: context,
    builder: (newContext) => Center(
      child: BlocProvider(
        create: (_) => TranslationEditorCubit<T, V>(
          editorCubit: BlocProvider.of<E>(context),
          selectedLanguageCode: languageCode,
        ),
        child: BlocListener<TranslationEditorCubit<T, V>,
            TranslationEditorState<V>>(
          listenWhen: (p, c) => p.saved != c.saved,
          listener: (context, state) {
            if (state.saved) Navigator.of(context).pop();
          },
          child: Builder(
            builder: (context) {
              return AlertDialog(
                contentPadding:
                    const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('✖️'),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.read<TranslationEditorCubit<T, V>>().saved(),
                    child: const Text('☑️'),
                  ),
                ],
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        languageCode.toLocale().toFlag(),
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: EditText<T, V, TranslationEditorCubit<T, V>>(
                        initInput: initInput,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

Future<void> showChooseLanguageCodeDialog<T extends TranslatableEntity,
    V extends StringValueObject, E extends EntityEditorCubit<T, V>>(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (newContext) => Center(
      child: AlertDialog(
        scrollable: true,
        content: BlocBuilder<E, EntityEditorState<T>>(
          bloc: BlocProvider.of<E>(context),
          builder: (newContext, state) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.entity!.translations
                  .getUnsupportedLanguageCodesOrCrash()
                  .size,
              itemBuilder: (newContext, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    showEditTextDialog<T, V, E>(
                      context: context,
                      languageCode: state.entity!.translations
                          .getUnsupportedLanguageCodesOrCrash()[index],
                      initInput: "",
                    );
                  },
                  leading: Text(
                    state.entity!.translations
                        .getUnsupportedLanguageCodesOrCrash()[index]
                        .toLocale()
                        .toFlag(),
                    style: const TextStyle(fontSize: 22),
                  ),
                  title: Text(
                    state.entity!.translations
                        .getUnsupportedLanguageCodesOrCrash()[index]
                        .toLocale()
                        .toLanguage(context),
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}

class EditText<T extends TranslatableEntity, V extends StringValueObject,
    E extends TranslationEditorCubit<T, V>> extends HookWidget {
  const EditText({
    Key? key,
    required this.initInput,
  }) : super(key: key);

  final String initInput;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController(text: initInput);

    textEditingController.selection = TextSelection(
        baseOffset: 0, extentOffset: textEditingController.text.length);

    final label = T == ChatBot
        ? "Name"
        : T == Question
            ? "Question"
            : T == AnswerOption
                ? "Answer Option"
                : "";

    return BlocBuilder<E, TranslationEditorState<V>>(
      builder: (context, state) {
        return Material(
          child: TextFormField(
            autofocus: true,
            maxLines: null,
            textInputAction: TextInputAction.done,
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            controller: textEditingController,
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(2),
              border: const UnderlineInputBorder(),
              hintStyle: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
              hintText: initInput.isEmpty ? "please enter a $label" : initInput,
              counterText: '',
            ),
            onChanged: (value) =>
                context.read<E>().translationChanged(input: value),
            validator: (_) {
              return state.translation != null
                  ? state.translation!.value.fold(
                      (failure) {
                        if (failure is EmptyString) {
                          return 'Cannot be empty';
                        } else if (failure is TooLongString) {
                          return 'Name is too long';
                        } else if (failure is MultipleLines) {
                          return 'Too many lines';
                        } else {
                          return 'Unknown Failure';
                        }
                      },
                      (_) => null,
                    )
                  : 'Cannot be empty';
            },
          ),
        );
      },
    );
  }
}
