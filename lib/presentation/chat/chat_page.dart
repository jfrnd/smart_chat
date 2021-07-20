// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/chat/chat_log/chat_log.dart';
import 'package:smart_chat/presentation/chat/input/input_controller_widget.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image_back_button.dart';
import 'package:smart_chat/presentation/core/pages/crud_failure_page.dart';
import 'package:smart_chat/utils/date_time_extensions.dart';

class ChatPage extends StatelessWidget {
  final UniqueId chatBotId;

  const ChatPage({Key? key, required this.chatBotId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatWatcherBloc>()
            ..add(
              ChatWatcherEvent.watchStarted(chatBotId: chatBotId),
            ),
        ),
        BlocProvider(create: (context) => getIt<ChatActorBloc>()),
        BlocProvider(
          create: (context) => QarSelectorBloc(
            chatWatcherBloc: BlocProvider.of<ChatWatcherBloc>(context),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          final imageUrl = context
              .select((ChatWatcherBloc bloc) => bloc.state.chatBot.imageUrl);
          return Scaffold(
            appBar: AppBar(
              actions: [
                TestButton(
                  chatBotId: chatBotId,
                ),
              ],
              leading: ChatBotImageBackButton(imageUrl: imageUrl),
              title: const Text('Chat'),
            ),
            body: BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
              buildWhen: (p, c) =>
                  p.failure != c.failure || c.isLoading != p.isLoading,
              builder: (context, state) {
                if (state.qars.size > 0) {
                  context
                      .read<QarSelectorBloc>()
                      .add(const QarSelectorEvent.mostRecentQarSelected());
                }
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.failure != null) {
                  return CrudFailureDisplay(failure: state.failure!);
                } else {
                  return const ChatPageBody();
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChatLog(),
        const InputController(),
      ],
    );
  }
}

class TestButton extends StatelessWidget {
  final UniqueId chatBotId;
  const TestButton({
    Key? key,
    required this.chatBotId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
        icon: const Icon(
          Icons.add,
          color: Colors.orange,
        ),
        label: const Text(
          """Create Questions
          for testing now
          """,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(color: Colors.orange),
        ),
        onPressed: () {
          context
              .read<QarSelectorBloc>()
              .add(QarSelectorEvent.newSessionCreated(chatBotId));
        },
      ),
    );
  }
}

class Timestamp extends StatelessWidget {
  const Timestamp({
    Key? key,
    required this.dateTime,
    required this.color,
  }) : super(key: key);

  final DateTime dateTime;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime.toDisplayedString(),
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: color,
        fontSize: 11,
      ),
    );
  }
}

class AnswerText extends StatelessWidget {
  final AnswerItemValue itemValue;
  final Question question;
  final TextStyle? textStyle;

  const AnswerText(
    this.itemValue,
    this.question, {
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return question.type.map(
      yesNo: (_) => MultipleChoiceAnswerText(itemValue.toUniqueId()),
      numeric: (_) => NumericAnswerText(
        NumericValue.fromItemValue(itemValue),
        question.unit,
      ),
      time: (_) => TimeAnswerText(TimeValue.fromItemValue(itemValue)),
      multipleChoice: (_) => MultipleChoiceAnswerText(itemValue.toUniqueId()),
      open: (_) => const Text('Open Question'),
    );
  }
}

class NumericAnswerText extends StatelessWidget {
  final NumericValue numericValue;
  final MUnit unit;

  const NumericAnswerText(
    this.numericValue,
    this.unit, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Text(numericValue.toDisplayedString(unit, 1));
}

class TimeAnswerText extends StatelessWidget {
  final TimeValue timeValue;

  const TimeAnswerText(
    this.timeValue, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(timeValue.toDisplayedString());
}

class MultipleChoiceAnswerText extends StatelessWidget {
  final UniqueId answerOptionId;

  const MultipleChoiceAnswerText(
    this.answerOptionId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
      buildWhen: (p, c) => p.answerOptions != c.answerOptions,
      builder: (context, state) {
        final answerOption = state.answerOptions.findById(answerOptionId) ??
            AnswerOption.error();
        return Text(
          answerOption.getTranslationAsString(
            LanguageCode.fromLocale(
              Localizations.localeOf(context),
            ),
          ),
        );
      },
    );
  }
}
