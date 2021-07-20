import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/multiple_choice_picker/multiple_choice_picker_cubit.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';

class MockQarSelectorBloc extends Mock implements QarSelectorBloc {}

class MockChatActorBloc extends Mock implements ChatActorBloc {}

class MockSettingsBloc extends Mock implements SettingsBloc {}

void main() {
  late MultipleChoicePickerCubit cubit;
  late MockQarSelectorBloc qarSelectorBloc;
  late MockChatActorBloc chatActorBloc;
  late MockSettingsBloc settingsBloc;

  setUp(() {
    qarSelectorBloc = MockQarSelectorBloc();
    chatActorBloc = MockChatActorBloc();
    settingsBloc = MockSettingsBloc();

    cubit = MultipleChoicePickerCubit(
        qarSelectorBloc: qarSelectorBloc,
        chatActorBloc: chatActorBloc,
        settingsBloc: settingsBloc);
  });

  tearDown(() {
    cubit.close();
    qarSelectorBloc.close();
    chatActorBloc.close();
    settingsBloc.close();
  });

  group('curTextInputChanged()', () {
    //TODO curTextInputChanged()
  });
  group('answerUnselected()', () {
    //TODO answerUnselected()
  });
  group('answerSelected()', () {
    //TODO answerSelected()
  });
  group('saved()', () {
    //TODO saved()
  });
  group('onNewAnswerOptionClicked()', () {
    //TODO onNewAnswerOptionClicked()
  });
  group('updateState()', () {
    //TODO updateState()
  });
}
