// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/editors/answer_option_editor_cubit.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/answer_options_diary.dart';

class MockIAnswerOptionCrudRepo extends Mock implements IAnswerOptionCrudRepo {}

void main() {
  late MockIAnswerOptionCrudRepo repo;
  late AnswerOptionEditorCubit cubit;

  setUp(() {
    registerFallbackValue<AnswerOption>(AnswerOption.empty());
    repo = MockIAnswerOptionCrudRepo();
    cubit = AnswerOptionEditorCubit(repo);
  });

  tearDown(() {
    reset(repo);
    cubit.close();
  });

  group('translationsChanged()', () {
    const newBody = 'newBody';
    blocTest(
      '''should emit: 
      [entity: same entity but with empty english body]
      [entity: same entity but with updated english body]
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(entity: answerOptionDayGood),
      act: (_) {
        cubit.translationChanged(
            languageCode: LanguageCode.en(), input: AnswerOptionBody.empty());
        cubit.translationChanged(
          languageCode: LanguageCode.en(),
          input: AnswerOptionBody(newBody),
        );
      },
      expect: () => [
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<AnswerOptionBody>(
              KtMap.from(
                {
                  LanguageCode.en(): AnswerOptionBody.empty(),
                  LanguageCode.de(): answerOptionBodyDayGoodDE
                },
              ),
            ),
          ),
        ),
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<AnswerOptionBody>(
              KtMap.from(
                {
                  LanguageCode.en(): AnswerOptionBody(newBody),
                  LanguageCode.de(): answerOptionBodyDayGoodDE
                },
              ),
            ),
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
      seed: () => cubit.state.copyWith(entity: answerOptionDayGood),
      act: (_) {
        cubit.translationDeleted(
          languageCode: LanguageCode.en(),
        );
      },
      expect: () => [
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<AnswerOptionBody>(
                KtMap.from({LanguageCode.de(): answerOptionBodyDayGoodDE})),
          ),
        ),
      ],
    );
  });
  group('initializedForEditing()', () {
    blocTest(
      'should emit: [isEditing: true, entity: fixtureEntity]',
      build: () => cubit,
      act: (_) => cubit.initializedForEditing(answerOptionDayGood),
      expect: () => [
        cubit.state.copyWith(
          entity: answerOptionDayGood,
          isEditing: true,
        ),
      ],
    );
  });
  group('initializedForCreating()', () {
    blocTest(
      'should emit: [isEditing: false, entity: fixtureEntity]',
      build: () => cubit,
      act: (_) => cubit.initializedForCreating(answerOptionDayGood),
      expect: () => [
        cubit.state.copyWith(
          entity: answerOptionDayGood,
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
      [isSaving: true, error: Right(unit)]
      [isSaving: false, error: ValueFailure]
      when entity is not valid
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(entity: AnswerOption.empty()),
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
        entity: answerOptionDayGood,
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
        verify(() => repo.create(answerOptionDayGood )),
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
            .thenAnswer((_) async => Right(answerOptionDayGood ));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: false,
        entity: answerOptionDayGood,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: Right(answerOptionDayGood ),
        ),
      ],
      verify: (_) => {
        verify(() => repo.create(answerOptionDayGood )),
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
        entity: answerOptionDayGood,
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
        verify(() => repo.update(answerOptionDayGood )),
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
            .thenAnswer((_) async => Right(answerOptionDayGood ));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: true,
        entity: answerOptionDayGood,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: Right(answerOptionDayGood ),
        ),
      ],
      verify: (_) => {
        verify(() => repo.update(answerOptionDayGood )),
        verifyNever(() => repo.create(any())),
      },
    );
  });
}
