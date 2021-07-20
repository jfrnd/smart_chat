// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';

@injectable
class AnswerOptionWatcherCubit extends EntityWatcherCubit<AnswerOption> {
  final IAnswerOptionWatcherApi answerOptionRepoWatcher;

  AnswerOptionWatcherCubit(this.answerOptionRepoWatcher)
      : super(answerOptionRepoWatcher);

  Future<void> watchAllOfChatBotStarted(UniqueId chatBotId) async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription = answerOptionRepoWatcher
        .watchAllOfChatBot(chatBotId)
        .listen((failureOrEntity) {
      failureOrEntity.fold(
        (failure) => failure == const CrudFailure.doesNotExist()
            ? emit(const EntityWatcherState.deleted())
            : emit(EntityWatcherState.loadFailure(failure)),
        (entityList) => emit(EntityWatcherState.loadSuccess(entityList)),
      );
    });
  }

  Future<void> watchAllOfQuestionStarted(UniqueId questionId) async {
    super.watchAllOfParentStarted(questionId);
  }
}
