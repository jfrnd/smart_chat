// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/presentation/chat/chat_log/answer_message_block.dart';
import 'package:smart_chat/presentation/chat/chat_log/question_message_widget.dart';

class ChatLog extends StatelessWidget {
  final GlobalKey<AnimatedListState> qarListKey =
      GlobalKey<AnimatedListState>();

  ChatLog({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatWatcherBloc, ChatWatcherState>(
      listenWhen: (p, c) => p.qars.size != c.qars.size,
      listener: (context, state) {
        qarListKey.currentState?.insertItem(
          0,
          duration: const Duration(milliseconds: 1000),
        );
        context
            .read<QarSelectorBloc>()
            .add(const QarSelectorEvent.mostRecentQarSelected());
      },
      buildWhen: (p, c) => p.qars.size != c.qars.size,
      builder: (context, state) {
        return Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                context
                    .read<QarSelectorBloc>()
                    .add(const QarSelectorEvent.mostRecentQarSelected());
              }
              return true;
            },
            child: AnimatedList(
              key: qarListKey,
              reverse: true,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              initialItemCount: state.qars.size,
              itemBuilder: (context, index, animation) {
                return SlideInTransition(
                  animation: animation,
                  child: QarBlock(
                    pContext: context,
                    qar: state.qars[index],
                    key: UniqueKey(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class QarBlock extends StatelessWidget {
  final BuildContext pContext;
  final Qar qar;

  const QarBlock({
    Key? key,
    required this.pContext,
    required this.qar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionMessage(pContext: pContext, qar: qar, key: UniqueKey()),
        AnswerMessageBlock(qar.id, key: UniqueKey()),
      ],
    );
  }
}

class SlideInTransition extends StatelessWidget {
  const SlideInTransition({
    this.fromLeft = true,
    required this.animation,
    required this.child,
  });

  final bool fromLeft;
  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final height = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.0,
            0.5,
            curve: Curves.easeInOut,
          ),
        );
        final position = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0.5,
            1.0,
            curve: Curves.easeInOut,
          ),
        );
        return FractionalTranslation(
          translation: fromLeft
              ? Offset(-1.0 + position.value, 0.0)
              : Offset(1.0 - position.value, 0.0),
          child: ClipRect(
            child: Align(
              heightFactor: math.max(height.value, 0.0),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
