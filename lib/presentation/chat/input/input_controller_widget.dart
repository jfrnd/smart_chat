// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/presentation/chat/input/multiple_choice_input/widget_multiple_choice_main.dart';
import 'package:smart_chat/presentation/chat/input/number_input/widget_numeric_input_main.dart';
import 'package:smart_chat/presentation/chat/input/time_input/widget_time_input_main.dart';
import 'package:smart_chat/presentation/chat/input/yes_no_input/yes_no_input_widget.dart';

class InputController extends StatelessWidget {
  const InputController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QarSelectorBloc, QarSelectorState>(
      buildWhen: (p, c) => p.question.type != c.question.type,
      builder: (context, state) {
        return AnimatedSwitcher(
          transitionBuilder: _transitionBuilder,
          layoutBuilder: (widget, list) =>
              Stack(children: [widget ?? Container(), ...list]),
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
          duration: const Duration(milliseconds: 1100),
          child: state.question.type.map(
            yesNo: (_) => const YesNoInput(),
            numeric: (_) => const NumericInput(),
            time: (_) => const TimeInput(),
            multipleChoice: (_) => const MultipleChoiceInput(),
            open: (_) => Container(),
          ),
        );
      },
    );
  }
}

Widget _transitionBuilder(Widget widget, Animation<double> animation) {
  final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
  return AnimatedBuilder(
    animation: rotateAnim,
    builder: (context, widget) {
      final value = min(rotateAnim.value, pi / 2);
      return Transform(
        transform: Matrix4.rotationX(value),
        alignment: Alignment.center,
        child: widget,
      );
    },
    child: widget,
  );
}
