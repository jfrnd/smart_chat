part of 'subscription_actor_cubit.dart';

@freezed
class SubscriptionActorState with _$SubscriptionActorState {
  const factory SubscriptionActorState({
    required Either<CrudFailure, Unit>? failureOrSuccess,
    required bool isLoading,
  }) = _SubscriptionActorState;

  factory SubscriptionActorState.initial() => SubscriptionActorState(
        isLoading: false,
        failureOrSuccess: null,
      );
}
