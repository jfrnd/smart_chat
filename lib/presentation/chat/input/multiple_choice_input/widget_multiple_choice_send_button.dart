// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/multiple_choice_picker/multiple_choice_picker_cubit.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultipleChoicePickerCubit, MultipleChoicePickerState>(
      builder: (context, state) {
        final isSaving =
            context.select((ChatActorBloc bloc) => bloc.state.isSaving);
        return SizedBox(
          height: 50,
          width: 50,
          child: isSaving
              ? const CircularProgressIndicator()
              : ClipOval(
                  child: Material(
                    color: state.selectedItemValues.isEmpty() &&
                            state.textInput.isEmpty
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                    child: state.selectedItemValues.isEmpty() &&
                            state.textInput.isEmpty
                        ? Icon(
                            Icons.send,
                            color: Colors.grey[300],
                          )
                        : InkWell(
                            onTap: () {
                              context.read<MultipleChoicePickerCubit>().saved();
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.grey[300],
                            ),
                          ),
                  ),
                ),
        );
      },
    );
  }
}
