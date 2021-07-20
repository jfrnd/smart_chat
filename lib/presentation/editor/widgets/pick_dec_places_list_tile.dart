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

class PickDecPlacesListTile extends StatelessWidget {
  const PickDecPlacesListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
      builder: (context, state) => state.entity?.type is Numeric
          ? CenteredListTile(
              leading: state.entity?.digits.getOrCrash() == 1
                  ? const Icon(Icons.plus_one)
                  : state.entity?.digits.getOrCrash() == 2
                      ? const Icon(Icons.exposure_plus_2)
                      : const Icon(Icons.exposure_zero),
              trailing: const Icon(Icons.edit),
              title: const Text('Decimal places'),
              onTap: () => showUnitPicker(context),
            )
          : Container(),
    );
  }

  Future<void> showUnitPicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (newContext) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          scrollable: true,
          title: const Text('Set number of decimal places'),
          content: BlocProvider.value(
            value: BlocProvider.of<QuestionEditorCubit>(context),
            child:
                BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
              builder: (context, state) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        context
                            .read<QuestionEditorCubit>()
                            .digitsChanged(index);
                        Navigator.of(context).pop();
                      },
                      leading: Icon(
                        Icons.circle,
                        color: state.entity?.digits.getOrCrash() == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      title: Text(
                        index.toString(),
                        style: TextStyle(
                          fontWeight: state.entity?.digits.getOrCrash() == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: state.entity?.digits.getOrCrash() == index
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
