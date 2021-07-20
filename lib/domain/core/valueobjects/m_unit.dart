// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'm_unit.freezed.dart';

const kg = 'kg';
const km = 'km';
const m = 'm';
const times = 'times';
const noUnit = 'no unit';

@freezed
class MUnit with _$MUnit {
  const factory MUnit.noUnit() = NoUnit;
  const factory MUnit.kg() = KG;
  const factory MUnit.km() = KM;
  const factory MUnit.meter() = METER;
  const factory MUnit.times() = TIMES;

  factory MUnit.fromString(String? str) {
    switch (str) {
      case kg:
        return const MUnit.kg();
      case km:
        return const MUnit.km();
      case m:
        return const MUnit.meter();
      case times:
        return const MUnit.times();
      default:
        return const MUnit.noUnit();
    }
  }
}

extension MUnitX on MUnit {
  IconData asIconData() {
    return map(
        kg: (_) => Icons.perm_scan_wifi_outlined,
        km: (_) => Icons.run_circle_rounded,
        meter: (_) => Icons.run_circle_outlined,
        times: (_) => Icons.replay_5,
        noUnit: (_) => Icons.circle);
  }

  String? asString() {
    return map(
      kg: (_) => kg,
      km: (_) => km,
      meter: (_) => m,
      times: (_) => times,
      noUnit: (_) => null,
    );
  }

  String toDisplayedString() {
    return map(
      kg: (_) => kg,
      km: (_) => km,
      meter: (_) => m,
      times: (_) => times,
      noUnit: (_) => noUnit,
    );
  }
}

final possibleUnits = [
  const MUnit.noUnit(),
  const MUnit.kg(),
  const MUnit.km(),
  const MUnit.meter(),
  const MUnit.times(),
];
