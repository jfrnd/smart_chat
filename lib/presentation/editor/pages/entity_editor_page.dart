// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide AboutListTile;

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:smart_chat/application/actors/answer_option_actor_cubit.dart';
import 'package:smart_chat/application/actors/chatbot_actor_cubit.dart';
import 'package:smart_chat/application/actors/question_actor_cubit.dart';

// Project imports:
import 'package:smart_chat/application/watchers/answer_option_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/chatbot_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/presentation/core/widgets/loading_in_progress_overlay.dart';
import 'package:smart_chat/presentation/editor/widgets/question_additional_settings_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/delete_entity_button.dart';
import 'package:smart_chat/presentation/editor/widgets/entities_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/image_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/question_type_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/subscription_settings_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/translations_list_tile.dart';
import 'package:smart_chat/presentation/core/flushbar_helper.dart';
import 'package:smart_chat/presentation/core/pages/crud_failure_page.dart';
import '../../../injection.dart';
import '../widgets/meta_data_list_tile.dart';

class EntityEditorPage<
    T extends TranslatableEntity,
    V extends StringValueObject,
    W extends EntityWatcherCubit<T>,
    A extends EntityActorCubit<T>> extends StatelessWidget {
  final UniqueId entityId;
  final List<Widget> fields;

  const EntityEditorPage({
    Key? key,
    required this.entityId,
    required this.fields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<W>()..watchOneStarted(entityId)),
        BlocProvider(create: (context) => getIt<A>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<A, EntityActorState<T>>(
            listenWhen: (p, c) => p.failureOrSuccess != c.failureOrSuccess,
            listener: (context, state) => state.failureOrSuccess?.fold(
              (f) => showCrudFailureMessage(f, context),
              (_) {},
            ),
          ),
          BlocListener<W, EntityWatcherState<T>>(
            listenWhen: (p, c) => c is Deleted || c is LoadFailure,
            listener: (context, state) {
              if (state is Deleted) AutoRouter.of(context).pop();
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            final isDeleting =
                context.select((A cubit) => cubit.state.isLoading);
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    title: BlocBuilder<W, EntityWatcherState<T>>(
                      builder: (context, state) => state.maybeMap(
                        orElse: () => Container(),
                        deleted: (_) => const Text('Deleted'),
                        loadInProgress: (_) => const Text('Loading...'),
                        loadFailure: (_) => const Text('Failure'),
                        loadSuccess: (state) => Text(state.entityList
                            .first()
                            .translations
                            .getStringOrCrash(LanguageCode.fromLocale(
                                Localizations.localeOf(context)))),
                      ),
                    ),
                  ),
                  body: BlocBuilder<W, EntityWatcherState<T>>(
                    builder: (context, state) {
                      return state.maybeMap(
                        orElse: () => Container(),
                        deleted: (_) => const Center(child: Text('Deleted')),
                        loadInProgress: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        loadFailure: (state) =>
                            CrudFailureDisplay(failure: state.failure),
                        loadSuccess: (watcherState) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: fields,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                LoadingInProgressOverlay(isLoading: isDeleting),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ChatBotEditorPage extends StatelessWidget {
  final UniqueId chatBotId;

  const ChatBotEditorPage({
    Key? key,
    required this.chatBotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityEditorPage<ChatBot, ChatBotName, ChatBotWatcherCubit,
        ChatBotActorCubit>(
      entityId: chatBotId,
      fields: [
        const ImageListTile(),
        const Divider(height: 0),
        const ChatBotNameListTile(),
        const Divider(height: 0),
        QuestionsListTile(chatBotId: chatBotId),
        const Divider(height: 0),
        const SubscriptionSettingsListTile(),
        const Divider(height: 0),
        const CreatedAtListTile<ChatBot, ChatBotWatcherCubit>(),
        const UpdatedAtListTile<ChatBot, ChatBotWatcherCubit>(),
        const Divider(height: 0),
        DeleteChatBotButton(chatBotId),
      ],
    );
  }
}

class QuestionEditorPage extends StatelessWidget {
  final UniqueId questionId;
  final UniqueId chatBotId;
  final BuildContext pContext;

  const QuestionEditorPage({
    Key? key,
    required this.questionId,
    required this.chatBotId,
    required this.pContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityEditorPage<Question, QuestionBody, QuestionWatcherCubit,
        QuestionActorCubit>(
      entityId: questionId,
      fields: [
        const QuestionBodyListTile(),
        const Divider(height: 0),
        AnswerOptionsListTile(
          chatBotId: chatBotId,
          questionId: questionId,
        ),
        const QuestionAdditionalSettingsListTile(),
        const Divider(height: 0),
        QuestionTypeListTile(),
        const Divider(height: 0),
        const CreatedAtListTile<Question, QuestionWatcherCubit>(),
        const UpdatedAtListTile<Question, QuestionWatcherCubit>(),
        const Divider(height: 0),
        DeleteQuestionButton(questionId),
      ],
    );
  }
}

class AnswerOptionEditorPage extends StatelessWidget {
  final BuildContext pContext;
  final UniqueId answerOptionId;

  const AnswerOptionEditorPage({
    Key? key,
    required this.answerOptionId,
    required this.pContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityEditorPage<AnswerOption, AnswerOptionBody,
        AnswerOptionWatcherCubit, AnswerOptionActorCubit>(
      entityId: answerOptionId,
      fields: [
        const AnswerOptionBodyListTile(),
        const Divider(height: 0),
        const CreatedAtListTile<AnswerOption, AnswerOptionWatcherCubit>(),
        const UpdatedAtListTile<AnswerOption, AnswerOptionWatcherCubit>(),
        const Divider(height: 0),
        DeleteAnswerOptionButton(answerOptionId),
      ],
    );
  }
}
