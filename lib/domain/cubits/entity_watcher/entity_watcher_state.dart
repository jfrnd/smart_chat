part of 'entity_watcher_cubit.dart';

@freezed
class EntityWatcherState<T extends Entity>
    with _$EntityWatcherState<T> {
  const factory EntityWatcherState.initial() = Initial;
  const factory EntityWatcherState.loadInProgress() = LoadInProgress;
  const factory EntityWatcherState.deleted() = Deleted;
  const factory EntityWatcherState.loadSuccess(KtList<T> entityList) =
      LoadSuccess;
  const factory EntityWatcherState.loadFailure(CrudFailure failure) =
      LoadFailure;
}
