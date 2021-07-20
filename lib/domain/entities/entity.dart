// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';

abstract class Entity<T> extends Equatable {
  final UniqueId id;
  final UniqueId createdBy;
  final DateTime createdAt;

  const Entity({
    required this.id,
    required this.createdBy,
    required this.createdAt,
  });

  bool get isValid => true;
  bool get isInvalid => false;

  T copyWith({
    UniqueId? id,
    UniqueId? createdBy,
    DateTime? createdAt,
  });

  T addMetaData({
    required UniqueId id,
    required UniqueId createdBy,
    required DateTime createdAt,
  }) =>
      copyWith(
        id: id,
        createdBy: createdBy,
        createdAt: createdAt,
      );
}

abstract class TranslatableEntity<T, V extends ValueObject<String>>
    extends Entity<T> {
  final UniqueId updatedBy;
  final DateTime updatedAt;
  final int position;

  final Translatable<V> translations;

  const TranslatableEntity({
    required UniqueId id,
    required UniqueId createdBy,
    required this.updatedBy,
    required DateTime createdAt,
    required this.updatedAt,
    required this.translations,
    required this.position,
  }) : super(id: id, createdBy: createdBy, createdAt: createdAt);

  String getTranslationAsString(LanguageCode languageCode) =>
      translations.getStringOrCrash(languageCode);

  @override
  T copyWith({
    UniqueId? id,
    Translatable<V>? translations,
    UniqueId? createdBy,
    DateTime? createdAt,
    UniqueId? updatedBy,
    DateTime? updatedAt,
    int? position,
  });

  @override
  T addMetaData({
    required UniqueId id,
    required UniqueId createdBy,
    required DateTime createdAt,
  }) =>
      copyWith(
        id: id,
        createdBy: createdBy,
        createdAt: createdAt,
        updatedBy: createdBy,
        updatedAt: createdAt,
      );

  T updateMetaData({
    required UniqueId updatedBy,
    required DateTime updatedAt,
  }) =>
      copyWith(
        updatedBy: updatedBy,
        updatedAt: updatedAt,
      );

  @override
  bool get isValid => translations.isValid();
  @override
  bool get isInvalid => translations.isInvalid();
}
