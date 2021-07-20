// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';

class YesNoInput extends StatelessWidget {
  const YesNoInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QarSelectorBloc, QarSelectorState>(
      builder: (context, state) {
        return Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[200],
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                offset: Offset(0, -0.1),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.grey[100],
                  child: InkWell(
                    onTap: () {
                      context.read<ChatActorBloc>().add(
                          ChatActorEvent.answerItemsCreated(
                              itemValues: listOf(AnswerItemValue.yes()),
                              qar: state.selectedQar!));
                    },
                    child: const Center(
                      child: Text('yes ☑️'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.grey[100],
                  child: InkWell(
                    onTap: () {
                      context.read<ChatActorBloc>().add(
                          ChatActorEvent.answerItemsCreated(
                              itemValues: listOf(AnswerItemValue.no()),
                              qar: state.selectedQar!));
                    },
                    child: const Center(
                      child: Text('no ✖️'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
