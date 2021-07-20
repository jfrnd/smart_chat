// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/numeric_slider/slider_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SliderCubit, SliderState>(
        builder: (context, state) {
          return Card(
            color: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => context
                              .read<SliderCubit>()
                              .valueDecrementedSmallStep(),
                          onLongPress: () => context
                              .read<SliderCubit>()
                              .valueDecrementedNormalStep(),
                          child: Icon(
                            Icons.fast_rewind_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        NumericValue(
                          state.value < state.minValue ||
                                  state.value > state.maxValue
                              ? state.minValue
                              : state.value,
                        ).toDisplayedString(state.unit, 1),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => context
                              .read<SliderCubit>()
                              .valueIncrementedSmallStep(),
                          onLongPress: () => context
                              .read<SliderCubit>()
                              .valueIncrementedNormalStep(),
                          child: Icon(
                            Icons.fast_forward_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Slider(
                  onChanged: (double value) {
                    context.read<SliderCubit>().valueChanged(value);
                  },
                  value: state.value < state.minValue ||
                          state.value > state.maxValue
                      ? state.minValue
                      : state.value,
                  max: state.maxValue,
                  min: state.minValue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
