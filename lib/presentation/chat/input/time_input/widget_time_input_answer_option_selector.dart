// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/application/chat/time_picker/time_picker_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/presentation/chat/chat_page.dart';

class AnswerOptionSelector extends StatelessWidget {
  const AnswerOptionSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QarSelectorBloc, QarSelectorState>(
      buildWhen: (p, c) =>
          p.possibleItemValues != c.possibleItemValues &&
          c.question.type is Time,
      builder: (context, state) {
        return SizedBox(
          height: 120,
          width: 100,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.possibleItemValues.size,
            itemBuilder: (context, index) {
              return AnswerChip(
                  TimeValue.fromItemValue(state.possibleItemValues[index]));
            },
          ),
        );
      },
    );
  }
}

class AnswerChip extends StatelessWidget {
  final TimeValue timeValue;

  const AnswerChip(
    this.timeValue, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TimePickerCubit>().allChanged(timeValue);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Colors.yellow[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TimeAnswerText(timeValue),
        ),
      ),
    );
  }
}
