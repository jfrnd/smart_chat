// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/editors/answer_option_editor_cubit.dart';
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/core/widgets/loading_in_progress_overlay.dart';
import 'package:smart_chat/presentation/editor/widgets/choose_question_type_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/edit_subscription_trigger_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/edit_translation_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/multi_selection_switch_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/pick_dec_places_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/pick_unit_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/set_min_max_widget.dart';
import 'package:smart_chat/presentation/core/flushbar_helper.dart';

class CreateEntityDialogPage<
    T extends TranslatableEntity,
    V extends StringValueObject,
    E extends EntityEditorCubit<T, V>> extends StatelessWidget {
  final String label;
  final T initEntity;
  final List<Widget> fields;

  const CreateEntityDialogPage({
    Key? key,
    required this.initEntity,
    required this.fields,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<E>()..initializedForCreating(initEntity),
        ),
      ],
      child: BlocConsumer<E, EntityEditorState<T>>(
        listenWhen: (p, c) =>
            p.saveFailureOrSuccess != c.saveFailureOrSuccess ||
            p.inputError != c.inputError,
        listener: (context, state) {
          state.saveFailureOrSuccess?.fold(
            (failure) => showCrudFailureMessage(failure, context),
            (unit) => AutoRouter.of(context).pop(),
          );
        },
        builder: (context, state) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('Create new $label'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () => context.read<E>().saved(),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                        EditTranslationListTile<T, V, E>(
                          translation: state.entity!.translations
                              .getValueObjectOrNull(LanguageCode.fromLocale(
                                  Localizations.localeOf(context))) as V?,
                          languageCode: LanguageCode.fromLocale(
                            Localizations.localeOf(context),
                          ),
                          showError:
                              state.inputError.fold((l) => true, (r) => false),
                        ),
                        const Divider(
                          height: 0,
                        ),
                      ] +
                      fields,
                ),
              ),
            ),
            LoadingInProgressOverlay(isLoading: state.isSaving),
          ],
        ),
      ),
    );
  }
}

class CreateChatBotDialogPage
    extends CreateEntityDialogPage<ChatBot, ChatBotName, ChatBotEditorCubit> {
  CreateChatBotDialogPage()
      : super(
          label: 'chatbot',
          initEntity: ChatBot.empty(),
          fields: [const EditSubscriptionTriggerListTile()],
        );
}

class CreateQuestionDialogPage extends CreateEntityDialogPage<Question,
    QuestionBody, QuestionEditorCubit> {
  CreateQuestionDialogPage(
    Question initQuestion,
  ) : super(
          label: 'question',
          initEntity: initQuestion,
          fields: [
            const Divider(height: 0),
            const ChooseQuestionTypeListTile(),
            const Divider(height: 0),
            const MultiSelectionSwitchListTile(),
            const Divider(height: 0),
            const PickUnitListTile(),
            const Divider(height: 0),
            const PickDecPlacesListTile(),
            const Divider(height: 0),
            const SetMinMaxWidget(),
          ],
        );
}

class CreateAnswerOptionDialogPage extends CreateEntityDialogPage<AnswerOption,
    AnswerOptionBody, AnswerOptionEditorCubit> {
  CreateAnswerOptionDialogPage(AnswerOption initAnswerOption)
      : super(
          label: 'answer Option',
          initEntity: initAnswerOption,
          fields: [],
        );
}
