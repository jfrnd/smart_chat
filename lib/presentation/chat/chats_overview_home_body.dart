// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_chat/application/chat/chats_overview_watcher/chats_overview_watcher_bloc.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';
import 'package:smart_chat/presentation/core/pages/crud_failure_page.dart';
import 'package:smart_chat/utils/date_time_extensions.dart';

import '../../injection.dart';

class ChatsOverviewHomeBody extends StatelessWidget {
  const ChatsOverviewHomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatsOverviewWatcherBloc>()
        ..add(const ChatsOverviewWatcherEvent.watchStarted()),
      child: BlocBuilder<ChatsOverviewWatcherBloc, ChatsOverviewWatcherState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.failure != null) {
            return CrudFailureDisplay(failure: state.failure!);
          } else if (state.chatBots.isEmpty()) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ListTile(
                    leading: Icon(
                      Icons.warning,
                      color: Colors.orange,
                    ),
                    title: Text(
                      "You haven't subscribed any chatbots yet!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(Icons.search,
                        color: Theme.of(context).primaryColor),
                    title: const Text(
                      "Discover and subscribe chatbots of other users",
                    ),
                  ),
                  const Text("or",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  ListTile(
                    leading: Icon(Icons.manage_accounts,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                        "Create your own chatsbots with the chatbot editor!"),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final chatBot = state.chatBots[index];
                return ChatTile(chatBot: chatBot);
              },
              itemCount: state.chatBots.size,
            );
          }
        },
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final ChatBot chatBot;

  const ChatTile({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          AutoRouter.of(context).push(ChatRoute(chatBotId: chatBot.id)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ChatBotImage(
                      imageUrl: chatBot.imageUrl,
                      height: MediaQuery.of(context).size.height * 1 / 12,
                      width: MediaQuery.of(context).size.height * 1 / 12,
                      placeholderIconData: Icons.photo),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ChatBotName(chatBot: chatBot),
                          DateTime(chatBot: chatBot),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Message(chatBot: chatBot),
                          UnansweredIndicator(chatBot: chatBot),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0.0,
            indent: 72,
            endIndent: 8,
          ),
        ],
      ),
    );
  }
}

class UnansweredIndicator extends StatelessWidget {
  const UnansweredIndicator({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  final ChatBot chatBot;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsOverviewWatcherBloc, ChatsOverviewWatcherState>(
      buildWhen: (p, c) =>
          p.isAnswered.get(chatBot.id) != c.isAnswered.get(chatBot.id),
      builder: (context, state) {
        final isAnswered = state.isAnswered.get(chatBot.id);
        if (isAnswered == null || isAnswered) {
          return Container();
        } else {
          return Icon(Icons.circle, color: Theme.of(context).primaryColor);
        }
      },
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  final ChatBot chatBot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatsOverviewWatcherBloc, ChatsOverviewWatcherState>(
        buildWhen: (p, c) =>
            p.lastMessages.get(chatBot.id) != c.lastMessages.get(chatBot.id),
        builder: (context, state) {
          final lastMsg = state.lastMessages.get(chatBot.id);
          return Text(
            lastMsg ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          );
        },
      ),
    );
  }
}

class DateTime extends StatelessWidget {
  const DateTime({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  final ChatBot chatBot;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsOverviewWatcherBloc, ChatsOverviewWatcherState>(
      buildWhen: (p, c) =>
          p.dateTime.get(chatBot.id) != c.dateTime.get(chatBot.id),
      builder: (context, state) {
        if (state.dateTime.get(chatBot.id) != null) {
          return Text(
            state.dateTime.get(chatBot.id)!.toDisplayedString(),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}

class ChatBotName extends StatelessWidget {
  const ChatBotName({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  final ChatBot chatBot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        chatBot.getTranslationAsString(
          LanguageCode.fromLocale(
            Localizations.localeOf(context),
          ),
        ),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
