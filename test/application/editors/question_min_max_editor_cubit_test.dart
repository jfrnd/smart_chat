// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/editors/min_max/question_min_max_editor_cubit.dart';
import 'package:smart_chat/application/editors/question_editor_cubit.dart';

// Project imports:
import 'package:smart_chat/domain/entities/question/question.dart';

class MockQuestionEditorCubit extends Mock implements QuestionEditorCubit {}

void main() {
  late MockQuestionEditorCubit editorCubit;
  late QuestionMinMaxEditorCubit cubit;

  setUp(() {
    registerFallbackValue<Question>(Question.empty());
    editorCubit = MockQuestionEditorCubit();
    cubit = QuestionMinMaxEditorCubit(editorCubit);
  });

  tearDown(() {
    editorCubit.close();
    cubit.close();
  });

  group('initialize()', () {
    //TODO initialize()
  });
}
