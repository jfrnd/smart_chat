// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';

class MockIChatBotCrudRepo extends Mock implements IChatBotCrudRepo {}

void main() {
  late MockIChatBotCrudRepo repo;
  late EntityActorCubit<ChatBot> cubit;

  setUp(() {
    registerFallbackValue<UniqueId>(UniqueId());
    registerFallbackValue<ChatBot>(ChatBot.empty());

    repo = MockIChatBotCrudRepo();
    cubit = EntityActorCubit<ChatBot>(repo);
  });

  tearDown(
    () {
      cubit.close();
      reset(repo);
    },
  );

  group('deleted()', () {
    blocTest(
      '''should call repo.delete()
      and emit:
      [isLoading: true, failure: null]
      [isLoading: false, failure: CrudFailure.unexpected()]
      when delete is not successful     
      ''',
      build: () {
        when(() => repo.delete(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        return cubit;
      },
      act: (_) => cubit.deleted(chatBotDiary.id),
      expect: () => [
        cubit.state.copyWith(
          isLoading: true,
          failureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isLoading: false,
          failureOrSuccess: const Left(CrudFailure.unexpected()),
        ),
      ],
      verify: (_) => verify(() => repo.delete(chatBotDiary.id)),
    );
    blocTest(
      '''should call repo.delete()
      and emit:
      [isLoading: true, failure: null]
      [isLoading: false, failure: null]
      when delete is successful     
      ''',
      build: () {
        when(() => repo.delete(any()))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (_) => cubit.deleted(chatBotDiary.id),
      expect: () => [
        cubit.state.copyWith(
          isLoading: true,
          failureOrSuccess: null,
        ),
        cubit.state.copyWith(
          isLoading: false,
          failureOrSuccess: null,
        ),
      ],
      verify: (_) => verify(() => repo.delete(chatBotDiary.id)),
    );
  });

  group('selectedDeleted()', () {
    //TODO selectedDeleted()
  });
  group('entitySelected()', () {
    //TODO entitySelected()
  });
  group('saved()', () {
    //TODO saved()
  });
  group('deactivateEditing()', () {
    //TODO deactivateEditing()
  });
  group('changeOrder()', () {
    //TODO changeOrder()
  });
  group('activateSorting()', () {
    //TODO activateSorting()
  });
}
