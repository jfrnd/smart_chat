// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'subscription_actor_state.dart';
part 'subscription_actor_cubit.freezed.dart';


@injectable
class SubscriptionActorCubit extends Cubit<SubscriptionActorState> {
  final ISubscriptionCrudRepo repo;

  SubscriptionActorCubit(this.repo) : super(SubscriptionActorState.initial());

  Future<void> subscribed(UniqueId chatBotId) async {
    emit(
      state.copyWith(
        failureOrSuccess: null,
        isLoading: true,
      ),
    );

    await repo.subscribe(chatBotId).then(
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

  Future<void> unSubscribed(UniqueId subscriptionId) async {
    emit(
      state.copyWith(
        failureOrSuccess: null,
        isLoading: true,
      ),
    );

    await repo.delete(subscriptionId).then(
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
}
