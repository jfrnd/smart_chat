// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';

@injectable
class ChatBotWatcherCubit extends EntityWatcherCubit<ChatBot> {
  final IChatBotWatcherApi chatBotWatcherRepo;
  final IAuthRepo authRepo;

  ChatBotWatcherCubit(this.chatBotWatcherRepo, this.authRepo)
      : super(chatBotWatcherRepo);

  Future<void> watchCreatedByStarted() async {
    final userId = await authRepo.getSignedInUserId();
    super.watchAllOfParentStarted(userId);
  }

  Future<void> watchAllSubscribedStarted() async {
    final userId = await authRepo.getSignedInUserId();

    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription = chatBotWatcherRepo
        .watchAllSubscribed(userId)
        .listen((failureOrEntities) {
      failureOrEntities.fold(
        (failure) => failure == const CrudFailure.doesNotExist()
            ? emit(const EntityWatcherState.deleted())
            : emit(EntityWatcherState.loadFailure(failure)),
        (entities) => emit(EntityWatcherState.loadSuccess(entities)),
      );
    });
  }

  Future<void> watchAllStarted() async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription =
        chatBotWatcherRepo.watchAll().listen((failureOrEntities) {
      failureOrEntities.fold(
        (failure) => failure == const CrudFailure.doesNotExist()
            ? emit(const EntityWatcherState.deleted())
            : emit(EntityWatcherState.loadFailure(failure)),
        (entities) => emit(EntityWatcherState.loadSuccess(entities)),
      );
    });
  }
}
