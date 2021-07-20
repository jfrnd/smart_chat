part of 'time_picker_cubit.dart';

@freezed
class TimePickerState with _$TimePickerState {
  const factory TimePickerState({
    required int hh,
    required int mm,
    required int ss,
  }) = _TimePickerState;

  factory TimePickerState.initial() => const TimePickerState(
        hh: 00,
        mm: 00,
        ss: 00,
      );
}
