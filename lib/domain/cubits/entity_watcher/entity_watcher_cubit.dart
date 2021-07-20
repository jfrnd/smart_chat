// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';

part 'entity_watcher_state.dart';
part 'entity_watcher_cubit.freezed.dart';

class EntityWatcherCubit<T extends Entity>
    extends Cubit<EntityWatcherState<T>> {
  late IWatcherApi<T> repo;

  EntityWatcherCubit(this.repo) : super(EntityWatcherState<T>.initial());

  StreamSubscription<Either<CrudFailure, KtList<T>>>? streamSubscription;

  @override
  Future<void> close() async {
    await streamSubscription?.cancel();
    return super.close();
  }

  Future<void> watchOneStarted(UniqueId id) async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription = repo.watchOne(id).listen(
      (failureOrEntities) {
        failureOrEntities.fold(
          (failure) => failure == const CrudFailure.doesNotExist()
              ? emit(const EntityWatcherState.deleted())
              : emit(EntityWatcherState.loadFailure(failure)),
          (entities) => emit(EntityWatcherState.loadSuccess(entities)),
        );
      },
    );
  }

  Future<void> watchAllOfParentStarted(UniqueId parentId) async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription =
        repo.watchAllOfParentEntity(parentId).listen((failureOrEntities) {
      failureOrEntities.fold(
        (failure) => failure == const CrudFailure.doesNotExist()
            ? emit(const EntityWatcherState.deleted())
            : emit(EntityWatcherState.loadFailure(failure)),
        (entities) => emit(EntityWatcherState.loadSuccess(entities)),
      );
    });
  }
}
