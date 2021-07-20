// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bubble_box/bubble_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/presentation/chat/chat_log/chat_log.dart';
import 'package:smart_chat/presentation/chat/chat_page.dart';

class AnswerMessageBlock extends StatelessWidget {
  final GlobalKey<AnimatedListState> itemListKey =
      GlobalKey<AnimatedListState>();

  final UniqueId qarId;

  AnswerMessageBlock(
    this.qarId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AnswerItem> itemList = [];

    Future<void> deleteItem(UniqueId answerItemId, int index) async {
      context
          .read<ChatActorBloc>()
          .add(ChatActorEvent.answerItemDeleted(answerItemId: answerItemId));
      itemList.removeAt(index);
      itemListKey.currentState?.removeItem(
        index,
        (context, animation) => Container(),
      );
    }

    return BlocConsumer<ChatWatcherBloc, ChatWatcherState>(
      listenWhen: (p, c) =>
          p.answerItems.filterByQarId(qarId).size <
          c.answerItems.filterByQarId(qarId).size,
      listener: (context, state) => itemListKey.currentState?.insertItem(
        0,
        duration: const Duration(milliseconds: 1100),
      ),
      buildWhen: (p, c) =>
          p.answerItems.filterByQarId(qarId).size <
          c.answerItems.filterByQarId(qarId).size,
      builder: (context, state) {
        itemList = state.answerItems
            .filterByQarId(qarId)
            .sortedByDescending((item) => item.createdAt)
            .asList();
        return AnimatedList(
          reverse: true,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          key: itemListKey,
          initialItemCount: itemList.length,
          itemBuilder: (context, index, animation) {
            final answerItem = itemList[index];
            return SlideInTransition(
              fromLeft: false,
              animation: animation,
              child: Dismissible(
                key: ValueKey<UniqueId>(answerItem.id),
                onDismissed: (direction) => deleteItem(answerItem.id, index),
                child: AnswerMessage(
                  itemId: answerItem.id,
                  key: ValueKey<UniqueId>(answerItem.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AnswerMessage extends StatelessWidget {
  final UniqueId itemId;
  const AnswerMessage({
    Key? key,
    required this.itemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
      buildWhen: (p, c) =>
          p.answerItems.findById(itemId) != c.answerItems.findById(itemId),
      builder: (context, state) {
        final item = state.answerItems.findById(itemId);
        if (item == null) {
          return Container();
        } else {
          return Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BubbleBox(
                  direction: BubbleDirection.right,
                  radius: 20,
                  position: BubblePosition(top: 1),
                  border: BubbleBoxBorder(color: Colors.grey, width: 0.1),
                  arrowHeight: 10,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 1,
                  backgroundColor: Colors.blue[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        AnswerText(
                          item.value,
                          context
                              .read<ChatWatcherBloc>()
                              .state
                              .questions
                              .findById(item.questionId)!,
                        ),
                        Timestamp(dateTime: item.createdAt, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
