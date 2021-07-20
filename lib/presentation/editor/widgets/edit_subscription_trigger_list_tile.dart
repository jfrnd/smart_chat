// Flutter imports:
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

// Project imports:
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';
import 'package:smart_chat/application/editors/subscription_triggers/subscription_triggers_editor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

class EditSubscriptionTriggerListTile extends StatelessWidget {
  const EditSubscriptionTriggerListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SubscriptionTriggersEditorCubit(context.read<ChatBotEditorCubit>()),
      child: BlocBuilder<ChatBotEditorCubit, EntityEditorState<ChatBot>>(
        builder: (context, state) {
          final chatBot = state.entity!;
          return InvertedListTile(
            leading: const Icon(Icons.calendar_today),
            trailing: const Icon(Icons.edit),
            overline: 'Triggers',
            body: chatBot.triggers.toDisplayedString(),
            onTap: () => showDialog(
              context: context,
              builder: (_) => EditSubscriptionTriggersDialogPage(
                context: context,
                initChatBot: chatBot,
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditSubscriptionTriggersDialogPage extends StatelessWidget {
  final BuildContext context;
  final ChatBot initChatBot;

  const EditSubscriptionTriggersDialogPage({
    Key? key,
    required this.context,
    required this.initChatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext newContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: BlocProvider.of<SubscriptionTriggersEditorCubit>(context)),
      ],
      child: BlocBuilder<SubscriptionTriggersEditorCubit,
          SubscriptionTriggersEditorState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Triggers"),
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  context.read<SubscriptionTriggersEditorCubit>().saved();
                  AutoRouter.of(context).pop();
                },
              ),
            ],
          ),
          body: BlocBuilder<SubscriptionTriggersEditorCubit,
              SubscriptionTriggersEditorState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.triggers[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => showDayPicker(context, index),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            item.value.first.toString(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => showTimePicker(context, index),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.timer),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            item.value.second.toString(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (state.triggers.size > 1)
                              IconButton(
                                onPressed: () => context
                                    .read<SubscriptionTriggersEditorCubit>()
                                    .itemDeleted(index),
                                icon: const Icon(Icons.delete),
                              )
                            else
                              Container(),
                          ],
                        );
                      },
                      itemCount: state.triggers.size,
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.add),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () => FlushbarHelper.createInformation(
                              message: "not implemented yet.")
                          .show(context),
                      label: const Text('Add new Trigger'),
                    ),
                    const SizedBox(height: 32.0)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<void> showTimePicker(BuildContext context, int index) {
  return showDialog(
    context: context,
    builder: (newContext) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<SubscriptionTriggersEditorCubit>(context)
              ..tempTimeValueReset(index),
          ),
        ],
        child: AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          scrollable: true,
          title: const Center(child: Text('Choose a time')),
          content: BlocBuilder<SubscriptionTriggersEditorCubit,
              SubscriptionTriggersEditorState>(
            builder: (context, state) {
              return NumberPicker(
                textMapper: (index) =>
                    possibleTimes[int.parse(index)].toString(),
                minValue: 0,
                maxValue: 47,
                value: possibleTimes.indexOf(state.tempTime),
                onChanged: (value) {
                  context
                      .read<SubscriptionTriggersEditorCubit>()
                      .tempTimeValueChanged(possibleTimes[value]);
                },
              );
            },
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
              label: const Text('cancel'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.check),
              onPressed: () {
                context
                    .read<SubscriptionTriggersEditorCubit>()
                    .timeValueChanged(index);
                AutoRouter.of(context).pop();
              },
              label: const Text('save'),
            )
          ],
        ),
      );
    },
  );
}

Future<void> showDayPicker(BuildContext context, int index) {
  return showDialog(
    context: context,
    builder: (newContext) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<SubscriptionTriggersEditorCubit>(context),
          ),
        ],
        child: AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          scrollable: true,
          title: const Center(child: Text('Choose a day')),
          content: BlocBuilder<SubscriptionTriggersEditorCubit,
              SubscriptionTriggersEditorState>(
            builder: (context, state) {
              final curSelectedDay = state.triggers[index].value.first;
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, idx) {
                  final day = SubscriptionFrequency(possibleFrequencies[idx]);
                  return ListTile(
                    onTap: () {
                      context
                          .read<SubscriptionTriggersEditorCubit>()
                          .dayValueChanged(index, day);
                      AutoRouter.of(context).pop();
                    },
                    leading: Icon(
                      Icons.calendar_today,
                      color: curSelectedDay == day
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    title: Text(
                      day.toString(),
                      style: TextStyle(
                        fontWeight: curSelectedDay == day
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: curSelectedDay == day
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  );
                },
                itemCount: possibleFrequencies.size,
              );
            },
          ),
        ),
      );
    },
  );
}
