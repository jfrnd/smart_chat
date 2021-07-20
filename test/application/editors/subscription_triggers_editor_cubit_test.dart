// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';

// Project imports:
import 'package:smart_chat/application/editors/subscription_triggers/subscription_triggers_editor_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';

class MockChatBotEditorCubit extends Mock implements ChatBotEditorCubit {}

void main() {
  late MockChatBotEditorCubit editorCubit;
  late SubscriptionTriggersEditorCubit cubit;

  setUp(() {
    registerFallbackValue<Question>(Question.empty());
    editorCubit = MockChatBotEditorCubit();
    cubit = SubscriptionTriggersEditorCubit(editorCubit);
  });

  tearDown(() {
    editorCubit.close();
    cubit.close();
  });

  group('timeValueChanged()', () {
    //TODO timeValueChanged()
  });
  group('dayValueChanged()', () {
    //TODO dayValueChanged()
  });
  group('itemDeleted()', () {
    //TODO itemDeleted()
  });
  group('tempTimeValueChanged()', () {
    //TODO tempTimeValueChanged()
  });
  group('tempTimeValueReset()', () {
    //TODO tempTimeValueReset()
  });
  group('triggerAdded()', () {
    //TODO triggerAdded()
  });
  group('saved()', () {
    //TODO saved()
  });
}
