// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';

import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/core/widgets/loading_in_progress_overlay.dart';
import 'package:smart_chat/presentation/editor/widgets/pick_dec_places_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/pick_unit_list_tile.dart';
import 'package:smart_chat/presentation/editor/widgets/set_min_max_widget.dart';
import 'package:smart_chat/presentation/core/flushbar_helper.dart';

class QuestionAdditionalSettingsListTile extends StatelessWidget {
  const QuestionAdditionalSettingsListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionWatcherCubit, EntityWatcherState<Question>>(
      builder: (context, state) {
        return state.maybeMap(
            orElse: () => Container(),
            loadSuccess: (state) {
              final question = state.entityList.first();

              return Visibility(
                visible: question.type is Numeric,
                child: ListTile(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => QuestionAdditionalSettingsDialogPage(
                      initQuestion: question,
                    ),
                  ),
                  title: const Text('Additional Settings'),
                  leading: const Icon(Icons.tune),
                  trailing: const Icon(Icons.edit),
                ),
              );
            });
      },
    );
  }
}

class QuestionAdditionalSettingsDialogPage extends StatelessWidget {
  final Question initQuestion;

  const QuestionAdditionalSettingsDialogPage({
    Key? key,
    required this.initQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<QuestionEditorCubit>()..initializedForEditing(initQuestion),
        ),
      ],
      child: BlocConsumer<QuestionEditorCubit, EntityEditorState<Question>>(
        listenWhen: (p, c) => p.saveFailureOrSuccess != c.saveFailureOrSuccess,
        listener: (context, state) {
          state.saveFailureOrSuccess?.fold(
            (failure) => showCrudFailureMessage(failure, context),
            (unit) => AutoRouter.of(context).pop(),
          );
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context, state) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Additional Settings'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () =>
                        context.read<QuestionEditorCubit>().saved(),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    PickUnitListTile(),
                    Divider(height: 0),
                    PickDecPlacesListTile(),
                    Divider(height: 0),
                    SetMinMaxWidget(),
                  ],
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
