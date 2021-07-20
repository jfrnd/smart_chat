// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';

@injectable
class UserWatcherCubit extends EntityWatcherCubit<User> {
  final IAuthRepo authRepo;
  final IUserWatcherApi userWatcherApi;

  UserWatcherCubit(this.userWatcherApi, this.authRepo) : super(userWatcherApi);

  Future<void> watchCreatorOfChatBotStarted(UniqueId chatBotId) async {
    await streamSubscription?.cancel();

    emit(const EntityWatcherState.loadInProgress());

    streamSubscription = userWatcherApi.watchOfChatBot(chatBotId).listen(
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

  Future<void> watchSignedInUserStarted() async {
    final userId = await authRepo.getSignedInUserId();
    return watchOneStarted(userId);
  }
}
