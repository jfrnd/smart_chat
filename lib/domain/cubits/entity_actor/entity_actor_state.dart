part of 'entity_actor_cubit.dart';

@freezed
class EntityActorState<T extends Entity> with _$EntityActorState<T> {
  const factory EntityActorState({
    required KtList<T> selectedEntities,
    required bool isLoading,
    required bool isEditing,
    required bool isSorting,
    required Either<CrudFailure, Unit>? failureOrSuccess,
  }) = _EntityActorState<T>;

  factory EntityActorState.initial() => EntityActorState(
        selectedEntities: listOf(),
        isLoading: false,
        isEditing: false,
        isSorting: false,
        failureOrSuccess: null,
      );
}
