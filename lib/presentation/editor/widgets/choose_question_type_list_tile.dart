// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

class ChooseQuestionTypeListTile extends StatelessWidget {
  const ChooseQuestionTypeListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
      builder: (context, state) => CenteredListTile(
        leading: Icon(
          state.entity?.type.asIconData(),
          color: Colors.black,
        ),
        trailing: const Icon(Icons.edit),
        title: const Text('Type'),
        subtitle: Text(state.entity?.type.toDisplayedString() ?? ''),
        onTap: () => showTypePicker(context),
      ),
    );
  }

  Future<void> showTypePicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (newContext) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          scrollable: true,
          title: const Text('Choose a question type'),
          content: BlocProvider.value(
            value: BlocProvider.of<QuestionEditorCubit>(context),
            child:
                BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
              builder: (context, state) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: possibleQuestionTypes.size,
                  itemBuilder: (context, index) {
                    final type = possibleQuestionTypes[index];
                    return ListTile(
                      onTap: () {
                        context
                            .read<QuestionEditorCubit>()
                            .typeChanged(type: type);
                        Navigator.of(context).pop();
                      },
                      leading: Icon(
                        type.asIconData(),
                        color: state.entity?.type == type
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      title: Text(
                        type.toDisplayedString(),
                        style: TextStyle(
                          fontWeight: state.entity?.type == type
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: state.entity?.type == type
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
