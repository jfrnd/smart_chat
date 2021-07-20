// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

// Project imports:
import 'package:smart_chat/application/chat/time_picker/time_picker_cubit.dart';

class NumberPickers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimePickerCubit, TimePickerState>(
      builder: (context, state) {
        return Card(
          color: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: NumberPicker(
                    itemHeight: 40,
                    infiniteLoop: true,
                    textStyle: const TextStyle(color: Colors.grey),
                    minValue: 0,
                    maxValue: 23,
                    value: state.hh,
                    textMapper: (numberText) => numberText.padLeft(2, '0'),
                    onChanged: (value) {
                      context.read<TimePickerCubit>().hhChanged(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                const Text(':'),
                Expanded(
                  child: NumberPicker(
                    itemHeight: 40,
                    infiniteLoop: true,
                    textStyle: const TextStyle(color: Colors.grey),
                    minValue: 0,
                    maxValue: 59,
                    textMapper: (numberText) => numberText.padLeft(2, '0'),
                    value: state.mm,
                    onChanged: (value) {
                      context.read<TimePickerCubit>().mmChanged(value);
                    },
                  ),
                ),
                const Text(':'),
                const SizedBox(width: 10),
                Expanded(
                  child: NumberPicker(
                    itemHeight: 40,
                    infiniteLoop: true,
                    textStyle: const TextStyle(color: Colors.grey),
                    minValue: 0,
                    maxValue: 59,
                    textMapper: (numberText) => numberText.padLeft(2, '0'),
                    value: state.ss,
                    onChanged: (value) {
                      context.read<TimePickerCubit>().ssChanged(value);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
