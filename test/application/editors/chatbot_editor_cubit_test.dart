// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/editors/chatbot_editor_cubit.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/translatable.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';

class MockIChatBotCrudRepo extends Mock implements IChatBotCrudRepo {}

void main() {
  late MockIChatBotCrudRepo repo;
  late ChatBotEditorCubit cubit;

  setUp(() {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    repo = MockIChatBotCrudRepo();
    cubit = ChatBotEditorCubit(repo);
  });

  tearDown(() {
    reset(repo);
    cubit.close();
  });

  group('translationsChanged()', () {
    const newName = 'newName';
    blocTest(
      '''should emit:
      [entity: same entity but with empty english name]
      [entity: same entity but with updated english name]
      ''',
      build: () => cubit,
      seed: () => cubit.state.copyWith(entity: chatBotDiary),
      act: (_) {
        cubit.translationChanged(
          languageCode: LanguageCode.en(),
          input: ChatBotName.empty(),
        );

        cubit.translationChanged(
          languageCode: LanguageCode.en(),
          input: ChatBotName(newName),
        );
      },
      expect: () => [
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<ChatBotName>(KtMap.from({
              LanguageCode.en(): ChatBotName.empty(),
              LanguageCode.de(): chatBotNameDiaryDE
            })),
          ),
        ),
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<ChatBotName>(KtMap.from({
              LanguageCode.en(): ChatBotName(newName),
              LanguageCode.de(): chatBotNameDiaryDE
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
      seed: () => cubit.state.copyWith(entity: chatBotDiary),
      act: (_) {
        cubit.translationDeleted(
          languageCode: LanguageCode.en(),
        );
      },
      expect: () => [
        cubit.state.copyWith(
          entity: cubit.state.entity?.copyWith(
            translations: Translatable<ChatBotName>(
                KtMap.from({LanguageCode.de(): chatBotNameDiaryDE})),
          ),
        ),
      ],
    );
  });
  group('initializedForEditing()', () {
    blocTest(
      'should emit: [isEditing: true, entity: chatBotDiary]',
      build: () => cubit,
      act: (_) => cubit.initializedForEditing(chatBotDiary),
      expect: () => [
        cubit.state.copyWith(
          entity: chatBotDiary,
          isEditing: true,
        ),
      ],
    );
  });
  group('initializedForCreating()', () {
    blocTest(
      'should emit: [isEditing: false, entity: chatBotDiary]',
      build: () => cubit,
      act: (_) => cubit.initializedForCreating(chatBotDiary),
      expect: () => [
        cubit.state.copyWith(
          entity: chatBotDiary,
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
      seed: () => cubit.state.copyWith(entity: ChatBot.empty()),
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
        entity: chatBotDiary,
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
        verify(() => repo.create(chatBotDiary )),
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
            .thenAnswer((_) async => Right(chatBotDiary ));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: false,
        entity: chatBotDiary,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: Right(chatBotDiary ),
        ),
      ],
      verify: (_) => {
        verify(() => repo.create(chatBotDiary )),
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
        entity: chatBotDiary,
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
        verify(() => repo.update(chatBotDiary )),
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
            .thenAnswer((_) async => Right(chatBotDiary ));
        return cubit;
      },
      seed: () => cubit.state.copyWith(
        isEditing: true,
        entity: chatBotDiary,
      ),
      act: (_) => cubit.saved(),
      expect: () => [
        cubit.state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isSaving: false,
          saveFailureOrSuccess: Right(chatBotDiary ),
        ),
      ],
      verify: (_) => {
        verify(() => repo.update(chatBotDiary )),
        verifyNever(() => repo.create(any())),
      },
    );
  });
}
