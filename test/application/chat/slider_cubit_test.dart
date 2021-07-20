import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/numeric_slider/slider_cubit.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';

class MockQarSelectorBloc extends Mock implements QarSelectorBloc {}

class MockChatActorBloc extends Mock implements ChatActorBloc {}

void main() {
  late SliderCubit cubit;
  late MockQarSelectorBloc qarSelectorBloc;
  late MockChatActorBloc chatActorBloc;

  setUp(() {
    qarSelectorBloc = MockQarSelectorBloc();
    chatActorBloc = MockChatActorBloc();
    cubit = SliderCubit(
      chatActorBloc: chatActorBloc,
      qarSelectorBloc: qarSelectorBloc,
    );
  });

  tearDown(() {
    cubit.close();
    qarSelectorBloc.close();
    chatActorBloc.close();
  });

  group('setInitValue()', () {
    //TODO setInitValue()
  });
  group('valueChanged()', () {
    //TODO valueChanged()
  });
  group('valueIncrementedSmallStep()', () {
    //TODO valueIncrementedSmallStep()
  });
  group('valueDecrementedSmallStep()', () {
    //TODO valueDecrementedSmallStep()
  });

  group('valueIncrementedNormalStep()', () {
    //TODO valueIncrementedNormalStep()
  });
  group('valueDecrementedNormalStep()', () {
    //TODO valueDecrementedNormalStep()
  });
  group('setMinMaxUnit()', () {
    //TODO setMinMaxUnit()
  });
  group('saved()', () {
    //TODO saved()
  });
}
