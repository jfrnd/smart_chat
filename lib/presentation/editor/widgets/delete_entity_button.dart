// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_chat/application/actors/answer_option_actor_cubit.dart';
import 'package:smart_chat/application/actors/chatbot_actor_cubit.dart';
import 'package:smart_chat/application/actors/question_actor_cubit.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';

class DeleteEntityButton<A extends EntityActorCubit> extends StatelessWidget {
  final String objectLabel;
  final UniqueId entityId;
  const DeleteEntityButton({
    Key? key,
    required this.objectLabel,
    required this.entityId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
      child: Card(
        color: Colors.red,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext newContext) {
                return AlertDialog(
                  title: const Text('Delete '),
                  content: const Text("Are you sure you want to delete this ?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(newContext).pop();
                        context.read<A>().deleted(entityId);
                      },
                      child: const Text("YES"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(newContext).pop();
                      },
                      child: const Text("CANCEL"),
                    ),
                  ],
                );
              },
            );
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Delete $objectLabel',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteChatBotButton extends DeleteEntityButton<ChatBotActorCubit> {
  const DeleteChatBotButton(UniqueId chatBotId)
      : super(
          objectLabel: "Chatbot",
          entityId: chatBotId,
        );
}

class DeleteQuestionButton extends DeleteEntityButton<QuestionActorCubit> {
  const DeleteQuestionButton(UniqueId questionId)
      : super(
          objectLabel: "Question",
          entityId: questionId,
        );
}

class DeleteAnswerOptionButton
    extends DeleteEntityButton<AnswerOptionActorCubit> {
  const DeleteAnswerOptionButton(UniqueId answerOptionId)
      : super(
          objectLabel: "Answer Option",
          entityId: answerOptionId,
        );
}
