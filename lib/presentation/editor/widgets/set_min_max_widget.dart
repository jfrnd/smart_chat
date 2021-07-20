// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/editors/min_max/question_min_max_editor_cubit.dart';
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';

class SetMinMaxWidget extends StatelessWidget {
  const SetMinMaxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, EntityEditorState<Question>>(
      builder: (context, state) =>
          state.entity?.type is Numeric ? const _SliderWidget() : Container(),
    );
  }
}

class _SliderWidget extends StatelessWidget {
  const _SliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unit =
        context.select((QuestionEditorCubit cubit) => cubit.state.entity?.unit);
    final digits = context.select(
        (QuestionEditorCubit cubit) => cubit.state.entity?.digits.getOrCrash());
    return BlocProvider(
      create: (context) => QuestionMinMaxEditorCubit(
          BlocProvider.of<QuestionEditorCubit>(context)),
      child: BlocBuilder<QuestionMinMaxEditorCubit, QuestionMinMaxEditorState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'min:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumericValue.fromDouble(state.min).toDisplayedString(
                          unit ?? const MUnit.noUnit(), digits ?? 0),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'max:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumericValue.fromDouble(state.max).toDisplayedString(
                          unit ?? const MUnit.noUnit(), digits ?? 0),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                RangeSlider(
                  labels:
                      RangeLabels('state.min.toString()', state.max.toString()),
                  values: RangeValues(state.min, state.max),
                  min: state.minMin,
                  max: state.maxMax,
                  onChangeEnd: (value) {
                    context.read<QuestionMinMaxEditorCubit>().updateMinMin();
                    context.read<QuestionMinMaxEditorCubit>().updateMaxMax();
                  },
                  onChanged: (value) {
                    context
                        .read<QuestionEditorCubit>()
                        .minValueChanged(value.start);
                    context
                        .read<QuestionEditorCubit>()
                        .maxValueChanged(value.end);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
