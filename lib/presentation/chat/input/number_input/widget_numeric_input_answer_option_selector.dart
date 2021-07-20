// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/numeric_slider/slider_cubit.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
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
          c.question.type is Numeric,
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: state.possibleItemValues.size,
            itemBuilder: (context, index) {
              return AnswerChip(
                numericValue:
                    NumericValue.fromItemValue(state.possibleItemValues[index]),
                unit: state.question.unit,
              );
            },
          ),
        );
      },
    );
  }
}

class AnswerChip extends StatelessWidget {
  final NumericValue numericValue;
  final MUnit unit;

  const AnswerChip({
    Key? key,
    required this.numericValue,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<SliderCubit>().valueChanged(
            numericValue.getOrCrash(),
          ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Colors.yellow[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NumericAnswerText(numericValue, unit),
        ),
      ),
    );
  }
}
