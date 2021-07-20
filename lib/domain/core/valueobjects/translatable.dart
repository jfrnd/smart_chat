// Package imports:
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/errors.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';

class Translatable<T extends ValueObject<String>>
    extends ValueObject<KtMap<LanguageCode, T>> {
  @override
  final Either<ValueFailure, KtMap<LanguageCode, T>> value;

  const Translatable._(this.value);

  factory Translatable(KtMap<LanguageCode, T> input) {
    switch (input.inspected) {
      case Input.isBlank:
        return Translatable<T>._(
          const Left(
            EmptyTranslatable(),
          ),
        );
      case Input.hasInvalidEntries:
        return Translatable<T>._(
          Left(
            InvalidTranslatable<T>(input),
          ),
        );
      case Input.hasBlankEntries:
        return Translatable<T>._(
          Left(
            UntrimmedTranslatable<T>(input),
          ),
        );
      case Input.isValid:
        return Translatable<T>._(
          Right(input),
        );
    }
  }

  factory Translatable.empty() =>
      Translatable<T>._(const Left(EmptyTranslatable()));

  Translatable<T> plus(LanguageCode languageCode, T valueObject) {
    final curMap = value.fold(
      (failure) => failure.failureInfo as KtMap<LanguageCode, T>,
      (validMap) => validMap,
    );
    final newMap = curMap.plus(KtMap.from({languageCode: valueObject}));

    return Translatable<T>(newMap);
  }

  Translatable<T> minus(LanguageCode languageCode) {
    final curMap = value.fold(
      (failure) => failure.failureInfo as KtMap<LanguageCode, T>,
      (validMap) => validMap,
    );
    if (curMap.size > 1) {
      return Translatable<T>(curMap.filterNot((it) => it.key == languageCode));
    } else {
      return this;
    }
  }

  Map<String, String> convertToRawMapOrCrash() {
    return value.fold(
        (f) => throw UnexpectedValueError(f),
        (r) => r.asMap().map(
            (key, value) => MapEntry(key.getOrCrash(), value.getOrCrash())));
  }

  KtList<LanguageCode> getSupportedLanguageCodesOrCrash() {
    return value.fold(
      (f) => throw UnexpectedValueError(f),
      (map) => map.filterValues((it) => it.isValid()).keys.toList(),
    );
  }

  KtList<LanguageCode> getUnsupportedLanguageCodesOrCrash() {
    return value.fold(
        (f) => throw UnexpectedValueError(f),
        (map) => possibleLanguageCodes.toImmutableList().filterNot(
            (it) => getSupportedLanguageCodesOrCrash().contains(it)));
  }

  T getValueObjectOrCrash(LanguageCode languageCode) {
    return getValueObjectOrNull(languageCode) != null
        ? getValueObjectOrNull(languageCode)!
        : _getDefaultValueObjectOrCrash();
  }

  String getStringOrCrash(LanguageCode languageCode) {
    return getValueObjectOrNull(languageCode) != null
        ? getValueObjectOrNull(languageCode)!.value.fold(
            (f) => _getDefaultValueObjectOrCrash().getOrCrash(), (str) => str)
        : _getDefaultValueObjectOrCrash().getOrCrash();
  }

  String getAllStringsOrCrash() {
    return value.fold(
      (f) => throw UnexpectedValueError(f),
      (map) {
        final translations = StringBuffer();

        map.values.forEachIndexed(
          (i, translation) {
            translations.write(translation.getOrCrash());
            if (i < map.size - 1) {
              translations.write(',  ');
            }
          },
        );
        return translations.toString();
      },
    );
  }

  T? getValueObjectOrNull(LanguageCode languageCode) {
    return value.fold(
      (failure) {
        final map = failure.failureInfo as KtMap<LanguageCode, T>;
        return map[languageCode];
      },
      (map) => map[languageCode],
    );
  }

  T _getDefaultValueObjectOrCrash() {
    return value.fold(
      (failure) {
        final invalidMap = failure.failureInfo as KtMap<LanguageCode, T>;
        final firstValidEntry = invalidMap.values.find((it) => it.isValid());
        if (firstValidEntry != null) {
          return firstValidEntry;
        } else {
          return throw UnexpectedValueError(failure);
        }
      },
      (ktMap) => ktMap.values.first(),
    );
  }
}

extension ValueObjectX on ValueObject<String> {
  bool get isBlank =>
      value.fold((failure) => failure is EmptyString, (value) => false);
}

extension KtMapX on KtMap<LanguageCode, ValueObject> {
  bool get isBlank =>
      isEmpty() ||
      values.toList().none((o) => o.value != const Left(EmptyString()));

  bool get hasInvalidEntries => values.toList().any((o) {
        return o.isInvalid() && o.value != const Left(EmptyString());
      });

  bool get hasBlankEntries =>
      values.toList().any((o) => o.value == const Left(EmptyString()));

  Input get inspected {
    if (isBlank) {
      return Input.isBlank;
    } else if (hasInvalidEntries) {
      return Input.hasInvalidEntries;
    } else if (hasBlankEntries) {
      return Input.hasBlankEntries;
    } else {
      return Input.isValid;
    }
  }
}

enum Input { isBlank, hasInvalidEntries, hasBlankEntries, isValid }

class InvalidTranslatable<T extends ValueObject>
    extends ValueFailure<KtMap<LanguageCode, T>> {
  final KtMap<LanguageCode, T> invalidValue;

  @override
  KtMap<LanguageCode, T> get failureInfo => invalidValue;

  const InvalidTranslatable(this.invalidValue);

  @override
  String toString() => 'Invalid Translatable';
}

class EmptyTranslatable<T extends ValueObject>
    extends ValueFailure<KtMap<LanguageCode, T>> {
  @override
  KtMap<LanguageCode, T> get failureInfo => const KtMap.empty();

  const EmptyTranslatable();

  @override
  String toString() => 'Please add a value for at least one language';
}

class UntrimmedTranslatable<T extends ValueObject>
    extends ValueFailure<KtMap<LanguageCode, T>> {
  final KtMap<LanguageCode, T> invalidValue;
  @override
  KtMap<LanguageCode, T> get failureInfo => invalidValue;

  const UntrimmedTranslatable(this.invalidValue);

  @override
  String toString() => 'Untrimmed Map';
}
