// Flutter imports:
import 'package:flutter/material.dart';

@immutable
class ImageUrl {
  const ImageUrl._(this.value);

  final String value;

  factory ImageUrl(String input) {
    return ImageUrl._(input);
  }

  factory ImageUrl.empty() {
    return const ImageUrl._('');
  }

  bool isEmpty() => value.isEmpty;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ImageUrl && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
