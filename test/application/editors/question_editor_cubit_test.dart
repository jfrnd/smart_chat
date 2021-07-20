// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/editors/question_editor_cubit.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/questions_diary.dart';
import '../../fixtures/chatbots/fitness/questions_fitness.dart';

class MockIQuestionRepoCrud extends Mock implements IQuestionCrudRepo {}

void main() {
  late MockIQuestionRepoCrud repo;
  late QuestionEditorCubit cubit;

  setUp(() {
    registerFallbackValue<Question>(Question.empty());
    repo = MockIQuestionRepoCrud();
    cubit = QuestionEditorCubit(repo);
  });

  tearDown(() {
    reset(repo);
    cubit.close();
  });

  group('typeChanged()', () {
    blocTest(
      '''should emit:
      [question with type: Time]
      [question with type: YesNo]
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(
        entity: questionDay.copyWith(
          type: const QuestionType.yesNo(),
        ),
      ),
      act: (_) {
        cubit.typeChanged(type: const QuestionType.time());
        cubit.typeChanged(type: const QuestionType.yesNo());
      },
      expect: () => [
        cubit.state.copyWith(
          entity: questionDay.copyWith(
            type: const QuestionType.time(),
          ),
        ),
        cubit.state.copyWith(
          entity: questionDay.copyWith(
            type: const QuestionType.yesNo(),
          ),
        ),
      ],
    );
  });
  group('unitChanged', () {
    blocTest(
      '''should emit:
      [question with unit: m]
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(
        entity: questionKM.copyWith(
          unit: const MUnit.meter(),
        ),
      ),
      act: (_) => cubit.unitChanged(unit: const MUnit.km()),
      expect: () => [
        cubit.state.copyWith(
          entity: questionKM.copyWith(
            unit: const MUnit.km(),
          ),
        ),
      ],
    );
  });
  group('translationsChanged()', () {
    const newQuestionBody = 'newQuestionBody';
    blocTest(
      '''should emit: 
      [entity: same entity but with empty english body]
      [entity: same entity but with updated english body]
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(entity: questionDay),
      act: (_) {
        cubit.translationChanged(
          languageCode: LanguageCode.en(),
          input: QuestionBody.empty(),
        );
        cubit.translationChanged(
          languageCode: LanguageCode.en(),
          input: QuestionBody(newQuestionBody),
        );
      },
      expect: () => [
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<QuestionBody>(KtMap.from({
              LanguageCode.en(): QuestionBody.empty(),
              LanguageCode.de(): questionBodyDayDE
            })),
          ),
        ),
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<QuestionBody>(KtMap.from({
              LanguageCode.en(): QuestionBody(newQuestionBody),
              LanguageCode.de(): questionBodyDayDE
            })),
          ),
        ),
      ],
    );
  });
  group('translationsDeleted()', () {
    blocTest(
      '''should emit:
      [entity: same entity but without english translation]
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(entity: questionDay),
      act: (_) {
        cubit.translationDeleted(
          languageCode: LanguageCode.en(),
        );
      },
      expect: () => [
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<QuestionBody>(
                KtMap.from({LanguageCode.de(): questionBodyDayDE})),
          ),
        ),
      ],
    );
  });
  group('initializedForEditing()', () {
    blocTest(
      'should emit: [isEditing: true, entity: fixtureEntity]',
      build: () => cubit,
      act: (_) => cubit.initializedForEditing(questionDay),
      expect: () => [
        cubit.state.copyWith(
          entity: questionDay,
          isEditing: true,
        ),
      ],
    );
  });
  group('initializedForCreating()', () {
    blocTest(
      'should emit: [isEditing: false, entity: fixtureEntity]',
      build: () => cubit,
      act: (_) => cubit.initializedForCreating(questionDay),
      expect: () => [
        cubit.state.copyWith(
          entity: questionDay,
          isEditing: false,
        ),
      ],
    );
  });
  group('saved(): entity not valid', () {
    blocTest(
      '''
      should
      not call repo,
      and emit:
      [isSaving: true, showErrorMessages: false]
      [isSaving: false, showErrorMessages: true]
      when entity is not valid
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(entity: Question.empty()),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          inputError: const Right(unit),
        ),
        cubit.state.copyWith(
          isSaving: false,
          inputError: const Left(EmptyTranslatable()),
        ),
      ],
      verify: (_) => {
        verifyZeroInteractions(repo),
      },
    );
  });
  group('saved(): entity is valid', () {
    blocTest(
      '''
      should
      call repo.create ,
      not call repo.update
      and emit:
      [isSaving: true, saveFailureOrSuccess: null]
      [isSaving: false, saveFailureOrSuccess: left(CrudFailure.unexpected())]
      when isEditing is false and
      when entity is valid but repo.create returns failure
      ''',
      build: () {
        when(() => repo.create(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: false,
        entity: questionDay,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: const Left(CrudFailure.unexpected()),
        ),
      ],
      verify: (_) => {
        verify(() => repo.create(questionDay)),
        verifyNever(() => repo.update(any())),
      },
    );
    blocTest(
      '''
      should
      call repo.create ,
      not call repo.update
      and emit:
      [isSaving: true, saveFailureOrSuccess: null]
      [isSaving: false, saveFailureOrSuccess: right(trimmed entity)]
      when isEditing is false and
      when entity is valid but repo.create returns failure
      ''',
      build: () {
        when(() => repo.create(any()))
            .thenAnswer((_) async => Right(questionDay));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: false,
        entity: questionDay,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: Right(questionDay),
        ),
      ],
      verify: (_) => {
        verify(() => repo.create(questionDay)),
        verifyNever(() => repo.update(any())),
      },
    );

    blocTest(
      '''
      should
      call repo.update ,
      not call repo.create
      and emit:
      [isSaving: true, saveFailureOrSuccess: null]
      [isSaving: false, saveFailureOrSuccess: left(CrudFailure.unexpected())]
      when isEditing is true and
      when entity is valid but repo.update returns failure
      ''',
      build: () {
        when(() => repo.update(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: true,
        entity: questionDay,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: const Left(CrudFailure.unexpected()),
        ),
      ],
      verify: (_) => {
        verify(() => repo.update(questionDay)),
        verifyNever(() => repo.create(any())),
      },
    );
    blocTest(
      '''
      should
      call repo.update ,
      not call repo.create
      and emit:
      [isSaving: true, saveFailureOrSuccess: null]
      [isSaving: false, saveFailureOrSuccess: right(trimmed entity)]
      when isEditing is true and
      when entity is valid but repo.update returns failure
      ''',
      build: () {
        when(() => repo.update(any()))
            .thenAnswer((_) async => Right(questionDay));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: true,
        entity: questionDay,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: Right(questionDay),
        ),
      ],
      verify: (_) => {
        verify(() => repo.update(questionDay)),
        verifyNever(() => repo.create(any())),
      },
    );
  });
}
