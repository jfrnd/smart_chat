// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/presentation/core/widgets/loading_in_progress_overlay.dart';
import 'package:smart_chat/presentation/editor/dialogs/create_entity_dialog_page.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';
import 'package:smart_chat/presentation/core/pages/crud_failure_page.dart';
import '../../../injection.dart';

class ManageEntitiesOverviewPage<
    T extends TranslatableEntity,
    W extends EntityWatcherCubit<T>,
    A extends EntityActorCubit<T>> extends StatelessWidget {
  final UniqueId parentId;
  final BuildContext context;
  final Function() openCreateEntityDialog;
  final Function(BuildContext context, UniqueId entityId) onTap;
  final String label;
  final bool isSortable;

  const ManageEntitiesOverviewPage({
    Key? key,
    required this.openCreateEntityDialog,
    required this.onTap,
    required this.label,
    required this.context,
    required this.isSortable,
    required this.parentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<W>()..watchAllOfParentStarted(parentId)),
        BlocProvider(create: (context) => getIt<A>()),
      ],
      child: BlocBuilder<W, EntityWatcherState<T>>(
        builder: (context, state) => state.maybeMap(
          orElse: () => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (state) => CrudFailureDisplay(failure: state.failure),
          loadSuccess: (state) {
            return BlocBuilder<A, EntityActorState<T>>(
              buildWhen: (p, c) =>
                  p.isEditing != c.isEditing ||
                  p.isLoading != c.isLoading ||
                  p.isSorting != c.isSorting,
              builder: (context, actorState) {
                return Stack(
                  children: [
                    Scaffold(
                      appBar: AppBar(
                        title: Text(label),
                        actions: [
                          Visibility(
                            visible: isSortable &&
                                !actorState.isSorting &&
                                !actorState.isEditing,
                            child: IconButton(
                              icon: const Icon(Icons.sort),
                              onPressed: () => context
                                  .read<A>()
                                  .activateSorting(state.entityList),
                            ),
                          ),
                          Visibility(
                            visible:
                                actorState.isEditing || actorState.isSorting,
                            child: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () =>
                                    context.read<A>().deactivateEditing()),
                          ),
                          Visibility(
                            visible: actorState.isSorting,
                            child: IconButton(
                              icon: const Icon(Icons.save),
                              onPressed: () {
                                context.read<A>().saved();
                                context.read<A>().deactivateEditing();
                              },
                            ),
                          ),
                          Visibility(
                            visible: actorState.isEditing,
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<A>().selectedDeleted();
                                context.read<A>().deactivateEditing();
                              },
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: Visibility(
                        visible: !actorState.isEditing,
                        child: FloatingActionButton(
                          onPressed: () => openCreateEntityDialog(),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      body: actorState.isSorting
                          ? ReorderableEntityList<T, A>()
                          : EntityList<T, A>(
                              onTap: onTap,
                              entitites: state.entityList,
                            ),
                    ),
                    LoadingInProgressOverlay(isLoading: actorState.isLoading),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class EntityList<T extends TranslatableEntity, A extends EntityActorCubit<T>>
    extends StatelessWidget {
  const EntityList({
    Key? key,
    required this.onTap,
    required this.entitites,
  }) : super(key: key);

  final Function(BuildContext context, UniqueId entityId) onTap;
  final KtList<T> entitites;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (newContext, index) {
          final entity = entitites[index];
          return BlocBuilder<A, EntityActorState<T>>(
            builder: (context, state) {
              return ListTile(
                tileColor: index.isOdd ? Colors.grey[200] : Colors.white,
                selectedTileColor: Colors.grey[300],
                onTap: () => state.isEditing
                    ? context.read<A>().entitySelected(entity)
                    : onTap(context, entity.id),
                onLongPress: () => context.read<A>().entitySelected(entity),
                selected: state.selectedEntities.contains(entity),
                trailing: Icon(
                  Icons.circle,
                  color: state.selectedEntities.contains(entity)
                      ? Colors.blue
                      : Colors.transparent,
                ),
                leading: EntityListTileLeading<T>(entity: entity),
                title: Text(
                  entity.getTranslationAsString(
                    LanguageCode.fromLocale(
                      Localizations.localeOf(context),
                    ),
                  ),
                ),
              );
            },
          );
        },
        itemCount: entitites.size,
      ),
    );
  }
}

class EntityListTileLeading<T extends TranslatableEntity>
    extends StatelessWidget {
  final T entity;

  const EntityListTileLeading({Key? key, required this.entity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (T) {
      case ChatBot:
        return ChatBotImage(
          imageUrl: (entity as ChatBot).imageUrl,
          height: MediaQuery.of(context).size.height * 1 / 12,
          width: MediaQuery.of(context).size.height * 1 / 12,
          placeholderIconData: Icons.photo,
        );
      case Question:
        return (entity as Question).type.asIcon();

      default:
        return const Icon(
          Icons.circle,
          color: Colors.grey,
        );
    }
  }
}

class ReorderableEntityList<T extends TranslatableEntity,
    A extends EntityActorCubit<T>> extends StatelessWidget {
  const ReorderableEntityList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<A, EntityActorState<T>>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: ReorderableListView.builder(
            shrinkWrap: true,
            dragStartBehavior: DragStartBehavior.down,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (newContext, index) {
              final entity = state.selectedEntities[index];
              return ListTile(
                leading: Text(
                  index.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                trailing: const Icon(Icons.reorder),
                tileColor: index.isOdd ? Colors.grey[200] : Colors.white,
                key: Key(entity.id.getOrCrash()),
                title: Text(
                  entity.getTranslationAsString(
                    LanguageCode.fromLocale(
                      Localizations.localeOf(context),
                    ),
                  ),
                ),
              );
            },
            itemCount: state.selectedEntities.size,
            onReorder: (int oldIndex, int newIndex) {
              context.read<A>().changeOrder(oldIndex, newIndex);
            },
          ),
        );
      },
    );
  }
}

class ManageChatbotsOverviewPage extends StatelessWidget {
  final BuildContext context;
  final UniqueId userId;

  const ManageChatbotsOverviewPage({
    Key? key,
    required this.context,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext newContext) {
    return ManageEntitiesOverviewPage<ChatBot, ChatBotWatcherCubit,
        ChatBotActorCubit>(
      isSortable: false,
      parentId: userId,
      context: context,
      label: 'My Chatbots',
      openCreateEntityDialog: () => showDialog(
        context: context,
        builder: (_) => CreateChatBotDialogPage(),
      ),
      onTap: (BuildContext context, UniqueId chatBotId) =>
          AutoRouter.of(context).push(
        ChatBotEditorRoute(chatBotId: chatBotId),
      ),
    );
  }
}

class ManageQuestionsOverviewPage extends StatelessWidget {
  final BuildContext context;
  final UniqueId chatBotId;

  const ManageQuestionsOverviewPage({
    Key? key,
    required this.context,
    required this.chatBotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext newContext) {
    return ManageEntitiesOverviewPage<Question, QuestionWatcherCubit,
        QuestionActorCubit>(
      isSortable: true,
      parentId: chatBotId,
      context: context,
      label: 'Questions',
      openCreateEntityDialog: () => showDialog(
        context: context,
        builder: (_) => CreateQuestionDialogPage(
          Question.createFor(chatBotId),
        ),
      ),
      onTap: (BuildContext context, UniqueId questionId) =>
          AutoRouter.of(context).push(
        QuestionEditorRoute(
            questionId: questionId, pContext: context, chatBotId: chatBotId),
      ),
    );
  }
}

class ManageAnswerOptionsOverviewPage extends StatelessWidget {
  final BuildContext context;
  final UniqueId questionId;
  final UniqueId chatBotId;

  const ManageAnswerOptionsOverviewPage({
    Key? key,
    required this.context,
    required this.questionId,
    required this.chatBotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext newContext) {
    return ManageEntitiesOverviewPage<AnswerOption, AnswerOptionWatcherCubit,
        AnswerOptionActorCubit>(
      isSortable: false,
      context: context,
      parentId: questionId,
      label: 'Answer options',
      openCreateEntityDialog: () => showDialog(
        context: context,
        builder: (_) => CreateAnswerOptionDialogPage(
          AnswerOption.createWithIds(
            chatBotId: chatBotId,
            questionId: questionId,
          ),
        ),
      ),
      onTap: (BuildContext context, UniqueId answerOptionId) =>
          AutoRouter.of(context).push(
        AnswerOptionEditorRoute(
            answerOptionId: answerOptionId, pContext: context),
      ),
    );
  }
}
