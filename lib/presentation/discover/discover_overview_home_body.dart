// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/actors/subscription/subscription_actor_cubit.dart';
import 'package:smart_chat/application/watchers/chatbot_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/subscription_watcher_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';
import 'package:smart_chat/presentation/core/pages/crud_failure_page.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';
import '../../../injection.dart';

class DiscoverOverviewHomeBody extends StatelessWidget {
  const DiscoverOverviewHomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatBotWatcherCubit>()..watchAllStarted(),
        ),
        BlocProvider(
          create: (context) => getIt<SubscriptionWatcherCubit>()
            ..watchAllOfSignedInUserStarted(),
        ),
        BlocProvider(
          create: (context) => getIt<SubscriptionActorCubit>(),
        ),
      ],
      child: BlocBuilder<ChatBotWatcherCubit, EntityWatcherState<ChatBot>>(
        builder: (context, state) {
          final subscriptions = context.select(
            (SubscriptionWatcherCubit cubit) => cubit.state is LoadSuccess
                ? (cubit.state as LoadSuccess).entityList
                : emptyList(),
          );
          return state.maybeMap(
            orElse: () => Container(),
            loadInProgress: (_) =>
                const Center(child: CircularProgressIndicator()),
            loadFailure: (state) => CrudFailureDisplay(failure: state.failure),
            loadSuccess: (state) => ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final chatBot = state.entityList[index];
                return ChatBotTile(
                  chatBot: chatBot,
                  subscribed: subscriptions.any(
                      (subscription) => subscription.chatBotId == chatBot.id),
                );
              },
              itemCount: state.entityList.size,
            ),
          );
        },
      ),
    );
  }
}

class ChatBotTile extends StatelessWidget {
  final ChatBot chatBot;
  final bool subscribed;

  const ChatBotTile({
    Key? key,
    required this.chatBot,
    required this.subscribed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CenteredListTile(
          contentPadding: const EdgeInsets.all(8),
          onTap: () {
            AutoRouter.of(context).push(
              DiscoverDetailsRoute(chatBotId: chatBot.id),
            );
          },
          trailing: subscribed
              ? const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    "subscribed!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : OutlinedButton(
                  onPressed: () {
                    if (subscribed) {
                    } else {
                      context
                          .read<SubscriptionActorCubit>()
                          .subscribed(chatBot.id);
                    }
                  },
                  child: const Text('subscribe'),
                ),
          leading: ChatBotImage(
            imageUrl: chatBot.imageUrl,
            height: MediaQuery.of(context).size.height * 1 / 12,
            width: MediaQuery.of(context).size.height * 1 / 12,
            placeholderIconData: Icons.photo,
          ),
          title: Text(
            chatBot.getTranslationAsString(
              LanguageCode.fromLocale(
                Localizations.localeOf(context),
              ),
            ),
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
