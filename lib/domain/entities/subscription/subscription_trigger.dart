// Package imports:
import 'package:equatable/equatable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/entities/subscription/subscription_frequency.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_time.dart';

class SubscriptionTrigger extends Equatable {
  final KtPair<SubscriptionFrequency, SubscriptionTime> value;

  const SubscriptionTrigger._(this.value);

  factory SubscriptionTrigger(
      {required SubscriptionFrequency frequency,
      required SubscriptionTime time}) {
    return SubscriptionTrigger._(KtPair(frequency, time));
  }

  String toDisplayedString() => "${value.first}, ${value.second}";

  SubscriptionTrigger withOffset(int offsetHH) {
    var hhWithOffset = value.second.hh - offsetHH;
    if (hhWithOffset > 24) hhWithOffset -= 24;
    if (hhWithOffset < 0) hhWithOffset += 24;

    return SubscriptionTrigger(
      frequency: value.first,
      time: SubscriptionTime(
        hh: hhWithOffset,
        mm: value.second.mm,
      ),
    );
    ;
  }

  @override
  List<Object?> get props => [value];
}

extension MapX on Map<String, String> {
  KtList<SubscriptionTrigger> toDomainList() => entries
      .map((entry) => SubscriptionTrigger(
          frequency: SubscriptionFrequency(entry.key),
          time: SubscriptionTime.fromString(entry.value)))
      .toImmutableList();
}

extension SubscriptionItemsX on KtList<SubscriptionTrigger> {
  Map<String, String> convertToRawMapOrCrash() => associate(
        (item) => KtPair(
          item.value.first.getOrCrash(),
          item.value.second.getOrCrash(),
        ),
      ).asMap();

  KtList<SubscriptionTrigger> withOffSet(int offsetHH) =>
      map((item) => item.withOffset(offsetHH));

  KtList<SubscriptionTrigger> convertToUTC() =>
      map((item) => item.withOffset(DateTime.now().timeZoneOffset.inHours));

  KtList<SubscriptionTrigger> convertToDeviceTime() => map(
      (item) => item.withOffset(DateTime.now().timeZoneOffset.inHours * -1));

  String toDisplayedString() => firstOrNull() == null
      ? ""
      : "${first().value.first}, ${first().value.second}";
}
