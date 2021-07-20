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

class MultiSelectionSwitchListTile extends StatelessWidget {
  const MultiSelectionSwitchListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
      builder: (context, state) => state.entity?.type is MultipleChoice
          ? CenteredListTile(
              leading: const Icon(Icons.ballot),
              subtitle: const Text('Enable multiple selections'),
              title: const Text('Multi Selection'),
              onTap: () => context
                  .read<QuestionEditorCubit>()
                  .toggleMultiSelection(
                      multiSelection: state.entity != null
                          ? !state.entity!.multiSelection
                          : false),
              trailing: Switch(
                value: state.entity?.multiSelection ?? false,
                onChanged: (value) => context
                    .read<QuestionEditorCubit>()
                    .toggleMultiSelection(multiSelection: value),
              ),
            )
          : Container(),
    );
  }
}
