// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_navigator_cubit.freezed.dart';
part 'home_navigator_state.dart';

@injectable
class HomeNavigatorCubit extends Cubit<HomeNavigatorState> {
  HomeNavigatorCubit() : super(const HomeNavigatorState.initial());

  void chatsSelected() {
    emit(const HomeNavigatorState.chatsSelected());
  }

  void discoverSelected() {
    emit(const HomeNavigatorState.discoverSelected());
  }

  void meSelected() {
    emit(const HomeNavigatorState.meSelected());
  }
}
