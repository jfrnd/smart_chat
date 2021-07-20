// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/utils/logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    logger.i('BLOC: Change from current state:\n${change.currentState}');
    logger.i('BLOC: to next state:\n${change.nextState}');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.i('BLOC CLOSED:$bloc');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    logger.i('BLOC CREATED:$bloc');
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('BLOC ERROR:\n$error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.i('BLOC EVENT:\n$event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.i(transition);
    super.onTransition(bloc, transition);
  }
}
