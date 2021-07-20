import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/application/chat/time_picker/time_picker_cubit.dart';

class MockQarSelectorBloc extends Mock implements QarSelectorBloc {}

class MockChatActorBloc extends Mock implements ChatActorBloc {}

void main() {
  late TimePickerCubit cubit;
  late MockQarSelectorBloc qarSelectorBloc;
  late MockChatActorBloc chatActorBloc;

  setUp(() {
    qarSelectorBloc = MockQarSelectorBloc();
    chatActorBloc = MockChatActorBloc();

    cubit = TimePickerCubit(
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
  group('allChanged()', () {
    //TODO allChanged()
  });
  group('saved()', () {
    //TODO saved()
  });
  group('hhChanged()', () {
    //TODO hhChanged()
  });
  group('mmChanged()', () {
    //TODO mmChanged()
  });
  group('ssChanged()', () {
    //TODO ssChanged()
  });
}
