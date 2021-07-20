// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'entity_editor_state.dart';
part 'entity_editor_cubit.freezed.dart';

class EntityEditorCubit<E extends TranslatableEntity,
    V extends ValueObject<String>> extends Cubit<EntityEditorState<E>> {
  final ICrudRepo<E> repo;

  EntityEditorCubit(
    this.repo,
  ) : super(EntityEditorState<E>.initial());

  void translationChanged({
    required LanguageCode languageCode,
    required V input,
  }) {
    final newTranslations =
        state.entity?.translations.plus(languageCode, input);

    emit(
      state.copyWith(
        entity: state.entity?.copyWith(translations: newTranslations) as E,
        inputError: const Right(unit),
      ),
    );
  }

  void translationDeleted({
    required LanguageCode languageCode,
  }) {
    final newTranslations = state.entity?.translations.minus(languageCode);

    emit(
      state.copyWith(
        entity: state.entity?.copyWith(translations: newTranslations) as E,
        inputError: const Right(unit),
      ),
    );
  }

  void initializedForEditing(E entity) {
    emit(state.copyWith(
      entity: entity,
      isEditing: true,
    ));
  }

  void initializedForCreating(E entity) {
    emit(state.copyWith(
      entity: entity,
      isEditing: false,
    ));
  }

  Future<void> saved() async {
    emit(
      state.copyWith(
        isSaving: true,
        saveFailureOrSuccess: null,
        inputError: const Right(unit),
      ),
    );

    if (state.entity!.isValid) {
      final savefailureOrSuccess = state.isEditing
          ? await repo.update(state.entity!)
          : await repo.create(state.entity!);

      emit(
        state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: savefailureOrSuccess.fold(
            (f) => left(f),
            (entity) => right(entity),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isSaving: false,
          inputError: state.entity!.translations.getFailureOrUnit(),
        ),
      );
    }
  }
}
