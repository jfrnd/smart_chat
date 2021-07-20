// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/multiple_choice_picker/multiple_choice_picker_cubit.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/presentation/chat/input/multiple_choice_input/widget_multiple_choice_answer_option_selector.dart';
import 'package:smart_chat/presentation/chat/input/multiple_choice_input/widget_multiple_choice_input_box_widget.dart';
import 'package:smart_chat/presentation/chat/input/multiple_choice_input/widget_multiple_choice_send_button.dart';

class MultipleChoiceInput extends StatelessWidget {
  const MultipleChoiceInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultipleChoicePickerCubit(
        qarSelectorBloc: BlocProvider.of<QarSelectorBloc>(context),
        chatActorBloc: BlocProvider.of<ChatActorBloc>(context),
        settingsBloc: BlocProvider.of<SettingsBloc>(context),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              // spreadRadius: 0.0,
              offset: Offset(0, -0.1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            MCAnswerOptionSelector(),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 80),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: const [
                    InputBox(),
                    SendButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
