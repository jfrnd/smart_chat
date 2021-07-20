// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/numeric_slider/slider_cubit.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/presentation/chat/input/number_input/widget_numeric_input_answer_option_selector.dart';
import 'package:smart_chat/presentation/chat/input/number_input/widget_numeric_input_send_button.dart';
import 'package:smart_chat/presentation/chat/input/number_input/widget_numeric_input_slider.dart';

class NumericInput extends StatelessWidget {
  const NumericInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SliderCubit(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AnswerOptionSelector(),
              Row(
                children: [
                  SliderWidget(),
                  const SendButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
