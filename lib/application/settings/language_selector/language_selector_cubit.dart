// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'language_selector_state.dart';
part 'language_selector_cubit.freezed.dart';

@injectable
class LanguageSelectorCubit extends Cubit<LanguageSelectorState> {
  LanguageSelectorCubit() : super(LanguageSelectorState.initial());

  void localeChanged(Locale locale) {
    emit(state.copyWith(locale: locale));
  }
}
