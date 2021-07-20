part of 'entity_editor_cubit.dart';

@freezed
class EntityEditorState<T> with _$EntityEditorState<T> {
  const factory EntityEditorState({
    required T? entity,
    required Either<ValueFailure, Unit> inputError,
    required bool isEditing,
    required bool isSaving,
    required Either<CrudFailure, T>? saveFailureOrSuccess,
  }) = _EntityEditorState<T>;

  factory EntityEditorState.initial() => EntityEditorState<T>(
        entity: null,
        isEditing: false,
        inputError: const Right(unit),
        isSaving: false,
        saveFailureOrSuccess: null,
      );
}
