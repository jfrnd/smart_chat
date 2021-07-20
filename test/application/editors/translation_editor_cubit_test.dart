// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';

// Project imports:
import 'package:smart_chat/application/editors/translation_editor/translation_editor_cubit.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/entities/question/question.dart';

class MockChatBotEditorCubit extends Mock implements ChatBotEditorCubit {}

void main() {
  late MockChatBotEditorCubit editorCubit;
  late TranslationEditorCubit cubit;

  setUp(() {
    registerFallbackValue<Question>(Question.empty());
    editorCubit = MockChatBotEditorCubit();
    cubit = TranslationEditorCubit(
      editorCubit: editorCubit,
      selectedLanguageCode: LanguageCode.en(),
    );
  });

  tearDown(() {
    editorCubit.close();
    cubit.close();
  });

  group('translationChanged()', () {
    //TODO translationChanged()
  });
  group('saved()', () {
    //TODO saved()
  });
}
