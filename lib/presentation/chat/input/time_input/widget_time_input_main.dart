// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/application/chat/time_picker/time_picker_cubit.dart';
import 'package:smart_chat/presentation/chat/input/time_input/widget_time_input_answer_option_selector.dart';
import 'package:smart_chat/presentation/chat/input/time_input/widget_time_input_number_pickers.dart';
import 'package:smart_chat/presentation/chat/input/time_input/widget_time_input_send_button.dart';

class TimeInput extends StatelessWidget {
  const TimeInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimePickerCubit(
        qarSelectorBloc: BlocProvider.of<QarSelectorBloc>(context),
        chatActorBloc: BlocProvider.of<ChatActorBloc>(context),
      ),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const AnswerOptionSelector(),
              Expanded(child: NumberPickers()),
              const SendButton(),
            ],
          ),
        ),
      ),
    );
  }
}
