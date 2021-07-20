// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

class PickUnitListTile extends StatelessWidget {
  const PickUnitListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
      builder: (context, state) {
        final question = state.entity!;

        return question.type.maybeMap(
          orElse: () => Container(),
          numeric: (_) => InvertedListTile(
            leading: Icon(
              question.unit.asIconData()
            ),
            trailing: const Icon(Icons.edit),
            overline: 'Unit',
            body: question.unit.toDisplayedString(),
            onTap: () => showUnitPicker(context, question),
          ),
        );
      },
    );
  }

  Future<void> showUnitPicker(BuildContext context, Question initQuestion) {
    return showDialog(
      context: context,
      builder: (newContext) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          scrollable: true,
          title: const Text('Choose a unit'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('✖️'),
            ),
            TextButton(
              onPressed: () {
                context.read<QuestionEditorCubit>().saved();
                Navigator.of(context).pop();
              },
              child: const Text('☑️'),
            ),
          ],
          content:
              BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
            bloc: BlocProvider.of<QuestionEditorCubit>(context),
            builder: (newContext, state) {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: possibleUnits.length,
                itemBuilder: (newContext, index) {
                  final unit = possibleUnits[index];
                  return ListTile(
                    onTap: () {
                      context
                          .read<QuestionEditorCubit>()
                          .unitChanged(unit: unit);
                      Navigator.of(context).pop();
                    },
                    leading: Icon(
                      unit.asIconData(),
                      color: state.entity?.unit == unit
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    title: Text(
                      unit.toDisplayedString(),
                      style: TextStyle(
                        fontWeight: state.entity?.unit == unit
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: state.entity?.unit == unit
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
