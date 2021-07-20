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
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/subscription_watcher_cubit.dart';
import 'package:smart_chat/application/watchers/user_watcher_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/domain/entities/subscription/subscription.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';
import 'package:smart_chat/utils/date_time_extensions.dart';
import '../../injection.dart';

class DiscoverDetailsPage extends StatelessWidget {
  const DiscoverDetailsPage({Key? key, required this.chatBotId})
      : super(key: key);

  final UniqueId chatBotId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ChatBotWatcherCubit>()..watchOneStarted(chatBotId),
        ),
        BlocProvider(
          create: (context) => getIt<QuestionWatcherCubit>()
            ..watchAllOfChatBotStarted(chatBotId),
        ),
        BlocProvider(
          create: (context) => getIt<UserWatcherCubit>()
            ..watchCreatorOfChatBotStarted(chatBotId),
        ),
        BlocProvider(
          create: (context) => getIt<SubscriptionWatcherCubit>()
            ..watchOfChatBotAndSignedInUserStarted(chatBotId),
        ),
        BlocProvider(
          create: (context) => getIt<SubscriptionActorCubit>(),
        ),
      ],
      child: BlocConsumer<ChatBotWatcherCubit, EntityWatcherState<ChatBot>>(
        listenWhen: (p, c) => c is Deleted || c is LoadFailure,
        listener: (context, state) {
          if (state is Deleted) AutoRouter.of(context).pop();
        },
        builder: (context, state) {
          return state.map(
            initial: (_) => Container(),
            deleted: (_) => const Text('Deleted'),
            loadInProgress: (_) =>
                const Center(child: CircularProgressIndicator()),
            loadFailure: (state) => Text(state.failure.toString()),
            loadSuccess: (state) =>
                ChatBotPageBody(chatBot: state.entityList.first()),
          );
        },
      ),
    );
  }
}

class ChatBotPageBody extends StatelessWidget {
  final ChatBot chatBot;

  const ChatBotPageBody({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chatBot.translations.getStringOrCrash(
            LanguageCode.fromLocale(
              Localizations.localeOf(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(chatBot: chatBot),
            const SizedBox(height: 8),
            const QuestionList(),
            const SizedBox(height: 8),
            MetaData(chatBot: chatBot),
            const SizedBox(height: 8),
            QuestionFrequency(chatBot: chatBot),
            const SizedBox(height: 8),
            UserSubscription(chatBotId: chatBot.id),
            const SizedBox(height: 8),
            SubscribeButton(chatBotId: chatBot.id),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}

class SubscribeButton extends StatelessWidget {
  final UniqueId chatBotId;
  const SubscribeButton({
    Key? key,
    required this.chatBotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionWatcherCubit,
        EntityWatcherState<Subscription>>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          deleted: (_) => const Text('Deleted'),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (state) => Text(state.failure.toString()),
          loadSuccess: (state) {
            final subscription = state.entityList.firstOrNull();

            return OutlinedButton(
              onPressed: () => subscription == null
                  ? context.read<SubscriptionActorCubit>().subscribed(chatBotId)
                  : context
                      .read<SubscriptionActorCubit>()
                      .unSubscribed(subscription.id),
              child: subscription == null
                  ? const Text("Subscribe!")
                  : const Text(
                      "Unsubscribe!",
                      style: TextStyle(color: Colors.orange),
                    ),
            );
          },
        );
      },
    );
  }
}

class QuestionFrequency extends StatelessWidget {
  final ChatBot chatBot;
  const QuestionFrequency({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: CenteredListTile(
        leading: const Icon(Icons.autorenew),
        title: Text(
            "${chatBot.triggers.first().value.first.getOrCrash()}, ${chatBot.triggers.first().value.second.getOrCrash()}"),
        subtitle: Text(
            "Daily push notifications at ${chatBot.triggers.first().value.second.getOrCrash()}"),
      ),
    );
  }
}

class UserSubscription extends StatelessWidget {
  final UniqueId chatBotId;
  const UserSubscription({
    Key? key,
    required this.chatBotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionWatcherCubit,
        EntityWatcherState<Subscription>>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          deleted: (_) => const Text('Deleted'),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (state) => Text(state.failure.toString()),
          loadSuccess: (state) {
            final subscription = state.entityList.firstOrNull();

            return Visibility(
              visible: subscription != null,
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: const [
                    CenteredListTile(
                      title: Center(
                        child: Text('subscribed',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                      ),
                      leading: Icon(Icons.subscriptions),
                      trailing: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MetaData extends StatelessWidget {
  final ChatBot chatBot;
  const MetaData({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserWatcherCubit, EntityWatcherState<User>>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          deleted: (_) => const Text('Deleted'),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (state) => Text(state.failure.toString()),
          loadSuccess: (state) => Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                InvertedListTile(
                  leading: const Icon(Icons.person),
                  overline: 'Creator:',
                  body: state.entityList.first().userName.getOrCrash(),
                ),
                InvertedListTile(
                  leading: const Icon(Icons.date_range),
                  overline: 'Created At:',
                  body: chatBot.createdAt.toDisplayedString(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  final ChatBot chatBot;

  const Header({
    Key? key,
    required this.chatBot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatBotImage(
              imageUrl: chatBot.imageUrl,
              height: MediaQuery.of(context).size.height * 3 / 12,
              width: MediaQuery.of(context).size.height * 3 / 12,
              placeholderIconData: Icons.photo,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  chatBot.translations.getStringOrCrash(
                    LanguageCode.fromLocale(
                      Localizations.localeOf(context),
                    ),
                  ),
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionList extends StatelessWidget {
  const QuestionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionWatcherCubit, EntityWatcherState<Question>>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          deleted: (_) => const Text('Deleted'),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadFailure: (state) => Text(state.failure.toString()),
          loadSuccess: (state) {
            final questions = state.entityList;
            return Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Questions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questions.size,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return ListTile(
                        leading: Icon(question.type.asIconData()),
                        title: Text(
                          question.translations.getStringOrCrash(
                            LanguageCode.fromLocale(
                              Localizations.localeOf(context),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
