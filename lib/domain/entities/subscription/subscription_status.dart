// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'subscription_status.freezed.dart';

const ACTIVE = 'active';
const INACTIVE = 'inactive';

final possibleSubscriptionStatus = listOf(
  const SubscriptionStatus.active(),
  const SubscriptionStatus.inactive(),
);

@freezed
class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus.active() = Active;
  const factory SubscriptionStatus.inactive() = Inactive;

  factory SubscriptionStatus.fromString(String status) {
    switch (status) {
      case ACTIVE:
        return const SubscriptionStatus.active();
      case INACTIVE:
        return const SubscriptionStatus.inactive();
      default:
        return const SubscriptionStatus.active();
    }
  }
}

extension SubscriptionStatusX on SubscriptionStatus {
  String asString() {
    return map(
      active: (_) => ACTIVE,
      inactive: (_) => INACTIVE,
    );
  }
}
