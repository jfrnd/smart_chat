// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'entity_actor_state.dart';
part 'entity_actor_cubit.freezed.dart';

class EntityActorCubit<T extends TranslatableEntity>
    extends Cubit<EntityActorState<T>> {
  final ICrudRepo<T> repo;

  EntityActorCubit(this.repo) : super(EntityActorState<T>.initial());

  Future<void> deleted(UniqueId entityId) async {
    emit(
      state.copyWith(
        failureOrSuccess: null,
        isLoading: true,
      ),
    );

    await repo.delete(entityId).then(
          (failureOrUnit) => failureOrUnit.fold(
            (failure) => emit(
              state.copyWith(
                isLoading: false,
                failureOrSuccess: Left(failure),
              ),
            ),
            (_) => emit(
              state.copyWith(
                isLoading: false,
              ),
            ),
          ),
        );
  }

  Future<void> selectedDeleted() async {
    if (state.isLoading == false) {
      emit(
        state.copyWith(
          isLoading: true,
          failureOrSuccess: null,
        ),
      );

      final entities = state.selectedEntities;

      final tasks = List.generate(
        entities.size,
        (index) => repo.delete(entities[index].id),
      );

      return Future.wait(tasks).then(
        (createResponses) {
          if (createResponses.haveAnyFailure) {
            state.copyWith(
              isEditing: false,
              isLoading: false,
              failureOrSuccess: Left(createResponses.firstFailure),
            );
          } else {
            emit(
              state.copyWith(
                isEditing: false,
                isLoading: false,
                failureOrSuccess: const Right(unit),
              ),
            );
          }
        },
      );
    }
  }

  void entitySelected(T entity) {
    final selectedEntities = state.selectedEntities.contains(entity)
        ? state.selectedEntities.minusElement(entity)
        : state.selectedEntities.plusElement(entity);

    emit(
      state.copyWith(
        selectedEntities: selectedEntities,
        isSorting: false,
        isEditing: selectedEntities.isNotEmpty(),
      ),
    );
  }

  Future<void> saved() async {
    if (state.isLoading == false) {
      emit(
        state.copyWith(
          isLoading: true,
          failureOrSuccess: null,
        ),
      );

      final entities = state.selectedEntities;

      final tasks =
          List.generate(entities.size, (index) => repo.update(entities[index]));

      return Future.wait(tasks).then(
        (createResponses) {
          if (createResponses.haveAnyFailure) {
            state.copyWith(
              isEditing: false,
              isLoading: false,
              failureOrSuccess: Left(createResponses.firstFailure),
            );
          } else {
            emit(
              state.copyWith(
                isEditing: false,
                isLoading: false,
                failureOrSuccess: const Right(unit),
              ),
            );
          }
        },
      );
    }
  }

  void deactivateEditing() {
    emit(
      state.copyWith(
        selectedEntities: listOf(),
        isEditing: false,
        isSorting: false,
      ),
    );
  }

  void changeOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final entitites = state.selectedEntities.asList().toList();
    final entity = entitites.removeAt(oldIndex);
    entitites.insert(newIndex, entity);

    emit(
      state.copyWith(
        selectedEntities: entitites
            .mapIndexed((idx, e) => e.copyWith(position: idx) as T)
            .toImmutableList(),
      ),
    );
  }

  void activateSorting(KtList<T> entitites) {
    emit(
      state.copyWith(
        isSorting: true,
        isEditing: false,
        selectedEntities:
            entitites.mapIndexed((idx, e) => e.copyWith(position: idx) as T),
      ),
    );
  }
}

extension ResponsesX on List<Either<CrudFailure, Object>> {
  CrudFailure get firstFailure => firstWhere(
        (failureOrUnit) => failureOrUnit.isLeft(),
      ).fold(
        (failure) => failure,
        (_) => throw Exception(),
      );
  bool get haveAnyFailure => any((failureOrUnit) => failureOrUnit.isLeft());
}
