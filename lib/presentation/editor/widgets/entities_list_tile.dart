// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/watchers/answer_option_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

class _TileItem<E extends TranslatableEntity> extends StatelessWidget {
  final Function() onTap;
  final KtList<E> entities;
  final String label;
  final bool showDetails;

  const _TileItem({
    Key? key,
    required this.onTap,
    required this.entities,
    required this.label,
    required this.showDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenteredListTile(
      onTap: () => onTap(),
      leading: const Icon(Icons.list),
      trailing: const Icon(Icons.edit),
      title: Text('$label (${entities.size.toString()})'),
      subtitle: showDetails
          ? Builder(
              builder: (context) {
                if (entities.isEmpty()) {
                  return Text(
                    'no ${label.toLowerCase()} added yet',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  );
                } else {
                  final entitiesString = StringBuffer();
                  entities.forEachIndexed(
                    (i, q) {
                      entitiesString.write(
                        q.getTranslationAsString(
                          LanguageCode.fromLocale(
                            Localizations.localeOf(context),
                          ),
                        ),
                      );
                      if (i < entities.size - 1) {
                        entitiesString.write(',  ');
                      }
                    },
                  );
                  return Text(
                    entitiesString.toString(),
                    overflow: TextOverflow.ellipsis,
                  );
                }
              },
            )
          : null,
    );
  }
}

class QuestionsListTile extends StatelessWidget {
  final UniqueId chatBotId;

  const QuestionsListTile({Key? key, required this.chatBotId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<QuestionWatcherCubit>()..watchAllOfChatBotStarted(chatBotId),
      child: BlocBuilder<QuestionWatcherCubit, EntityWatcherState<Question>>(
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => Container(),
            loadInProgress: (_) =>
                const Center(child: CircularProgressIndicator()),
            loadFailure: (state) => Text(state.failure.toString()),
            loadSuccess: (state) {
              final questions = state.entityList;
              return _TileItem(
                  showDetails: false,
                  label: 'Questions',
                  onTap: () => AutoRouter.of(context).push(
                        ManageQuestionsOverviewRoute(
                          context: context,
                          chatBotId: chatBotId,
                        ),
                      ),
                  entities: questions);
            },
          );
        },
      ),
    );
  }
}

class AnswerOptionsListTile extends StatelessWidget {
  final UniqueId questionId;
  final UniqueId chatBotId;

  const AnswerOptionsListTile({
    Key? key,
    required this.questionId,
    required this.chatBotId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionWatcherCubit, EntityWatcherState<Question>>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          loadSuccess: (state) {
            return state.entityList.first().type.maybeMap(
                  orElse: () => Container(),
                  multipleChoice: (_) => BlocProvider(
                    create: (context) => getIt<AnswerOptionWatcherCubit>()
                      ..watchAllOfParentStarted(questionId),
                    child: BlocBuilder<AnswerOptionWatcherCubit,
                        EntityWatcherState<AnswerOption>>(
                      builder: (context, state) {
                        return state.maybeMap(
                          orElse: () => Container(),
                          loadInProgress: (_) =>
                              const Center(child: CircularProgressIndicator()),
                          loadFailure: (state) =>
                              Text(state.failure.toString()),
                          loadSuccess: (state) {
                            final answerOptions = state.entityList;
                            return _TileItem(
                              showDetails: true,
                              label: 'Answer Options',
                              onTap: () => AutoRouter.of(context).push(
                                ManageAnswerOptionsOverviewRoute(
                                  context: context,
                                  chatBotId: chatBotId,
                                  questionId: questionId,
                                ),
                              ),
                              entities: answerOptions,
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
          },
        );
      },
    );
  }
}
