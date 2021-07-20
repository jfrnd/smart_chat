// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/editors/answer_option_editor_cubit.dart';
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/application/watchers/answer_option_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/chatbot_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/presentation/editor/dialogs/translations_editor_dialog_page.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';
import 'package:smart_chat/utils/locale_extensions.dart';

class TranslationsListTile<
    T extends TranslatableEntity,
    V extends StringValueObject,
    W extends EntityWatcherCubit<T>,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  final String label;

  const TranslationsListTile({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<W, EntityWatcherState<T>>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          loadSuccess: (state) {
            final entity = state.entityList.first();
            return CenteredListTile(
              onTap: () => showDialog(
                context: context,
                builder: (_) => TranslationsEditorDialogPage<T, V, E>(
                  initEntity: entity,
                  context: context,
                ),
              ),
              leading: const Icon(Icons.translate),
              title: Text(
                entity.translations.getStringOrCrash(
                    LanguageCode.fromLocale(Localizations.localeOf(context))),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                entity.translations
                    .getSupportedLanguageCodesOrCrash()
                    .asList()
                    .map((it) => it.toLocale().toFlag())
                    .toString()
                    .cutBrackets(),
                style: const TextStyle(color: Colors.black),
              ),
              trailing: const Icon(Icons.edit),
            );
          },
        );
      },
    );
  }
}

class ChatBotNameListTile extends TranslationsListTile<ChatBot, ChatBotName,
    ChatBotWatcherCubit, ChatBotEditorCubit> {
  const ChatBotNameListTile() : super(label: "Name");
}

class QuestionBodyListTile extends TranslationsListTile<Question, QuestionBody,
    QuestionWatcherCubit, QuestionEditorCubit> {
  const QuestionBodyListTile() : super(label: "Question Body");
}

class AnswerOptionBodyListTile extends TranslationsListTile<AnswerOption,
    AnswerOptionBody, AnswerOptionWatcherCubit, AnswerOptionEditorCubit> {
  const AnswerOptionBodyListTile() : super(label: "Answer Option Body");
}

extension StringX on String {
  String cutBrackets() => substring(1, length - 1);
}
