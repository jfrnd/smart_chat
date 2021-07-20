part of 'slider_cubit.dart';

@freezed
class SliderState with _$SliderState {
  const factory SliderState({
    required double value,
    required double minValue,
    required double maxValue,
    required MUnit unit,
  }) = _SliderState;

  factory SliderState.initial() => const SliderState(
        value: 0.0,
        minValue: 0.0,
        maxValue: 0.0,
        unit: MUnit.noUnit(),
      );
}
