part of 'home_navigator_cubit.dart';

@freezed
class HomeNavigatorState with _$HomeNavigatorState {
  const factory HomeNavigatorState.initial() = _Initial;
  const factory HomeNavigatorState.chatsSelected() = ChatsSelected;
  const factory HomeNavigatorState.discoverSelected() = DiscoverSelected;
  const factory HomeNavigatorState.meSelected() = MeSelected;
}
