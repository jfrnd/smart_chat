// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';
import 'package:smart_chat/application/watchers/chatbot_watcher_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/core/widgets/loading_in_progress_overlay.dart';
import 'package:smart_chat/presentation/core/flushbar_helper.dart';
import '../list_tiles/../widgets/edit_subscription_trigger_list_tile.dart';

class SubscriptionSettingsListTile extends StatelessWidget {
  const SubscriptionSettingsListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBotWatcherCubit, EntityWatcherState<ChatBot>>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          loadSuccess: (state) => ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => SubscriptionSettingsDialogPage(
                initChatBot: state.entityList.first(),
              ),
            ),
            title: const Text('Subscription Settings'),
            leading: const Icon(Icons.calendar_today),
            trailing: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}

class SubscriptionSettingsDialogPage extends StatelessWidget {
  final ChatBot initChatBot;

  const SubscriptionSettingsDialogPage({
    Key? key,
    required this.initChatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ChatBotEditorCubit>()..initializedForEditing(initChatBot),
        ),
      ],
      child: BlocConsumer<ChatBotEditorCubit, EntityEditorState<ChatBot>>(
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
                title: const Text('Subscription Settings'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () => context.read<ChatBotEditorCubit>().saved(),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const EditSubscriptionTriggerListTile(),
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
