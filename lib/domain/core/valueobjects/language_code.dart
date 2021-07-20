// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

class LanguageCode extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  const LanguageCode._(this.value);

  factory LanguageCode(String input) {
    return LanguageCode._(validateSingleLine(input));
  }

  factory LanguageCode.fromLocale(Locale locale) {
    return LanguageCode(locale.languageCode);
  }

  Locale toLocale() => Locale(getOrCrash());

  factory LanguageCode.de() => LanguageCode(DE);
  factory LanguageCode.en() => LanguageCode(EN);
  factory LanguageCode.fr() => LanguageCode(FR);
  factory LanguageCode.es() => LanguageCode(ES);
  factory LanguageCode.it() => LanguageCode(IT);
  factory LanguageCode.pt() => LanguageCode(PT);
  factory LanguageCode.zh() => LanguageCode(ZH);
  factory LanguageCode.ru() => LanguageCode(RU);
  factory LanguageCode.ko() => LanguageCode(KO);
  factory LanguageCode.ja() => LanguageCode(JA);
  factory LanguageCode.tr() => LanguageCode(TR);
  factory LanguageCode.math() => LanguageCode(MATH);
}

const EN = 'en';
const DE = 'de';
const ES = 'es';
const FR = 'fr';
const IT = 'it';
const PT = 'pt';
const ZH = 'zh';
const RU = 'ru';
const KO = 'ko';
const JA = 'ja';
const TR = 'tr';
const MATH = 'math';

final possibleLanguageCodes = [
  LanguageCode.de(),
  LanguageCode.en(),
  LanguageCode.fr(),
  LanguageCode.es(),
  LanguageCode.it(),
  LanguageCode.pt(),
  LanguageCode.zh(),
  LanguageCode.ru(),
  LanguageCode.ko(),
  LanguageCode.ja(),
  LanguageCode.tr(),
];
