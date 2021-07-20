// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/watchers/chatbot_watcher_cubit.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../fixtures/user.dart';

class MockIChatBotWatcherApi extends Mock implements IChatBotWatcherApi {}

class MockIAuthRepo extends Mock implements IAuthRepo {}

void main() {
  late ChatBotWatcherCubit cubit;
  late MockIChatBotWatcherApi repo;
  late MockIAuthRepo authRepo;

  setUp(() {
    repo = MockIChatBotWatcherApi();
    authRepo = MockIAuthRepo();
    cubit = ChatBotWatcherCubit(repo, authRepo);
  });

  tearDown(() {
    cubit.close();
    reset(repo);
  });

  group('watchOneStarted()', () {
    blocTest(
      '''should call repo.watchOne() and 
      emit:
      [LoadInProgress],
      [LoadFailure]
      when repo returns failure
      ''',
      build: () {
        when(() => repo.watchOne(chatBotDiary.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.unexpected())));
        return cubit;
      },
      act: (_) => cubit.watchOneStarted(chatBotDiary.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.loadFailure(CrudFailure.unexpected()),
      ],
      verify: (_) => repo.watchOne(chatBotDiary.id),
    );
    blocTest(
      '''should call repo.watchOne() and 
      emit:
      [LoadInProgress],
      [Deleted]
      when repo returns doesNotExist
       ''',
      build: () {
        when(() => repo.watchOne(chatBotDiary.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.doesNotExist())));
        return cubit;
      },
      act: (_) => cubit.watchOneStarted(chatBotDiary.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.deleted(),
      ],
      verify: (_) => repo.watchOne(chatBotDiary.id),
    );
    blocTest(
      '''should call repo.watchOne() and 
      emit:
      [LoadInProgress],
      [LoadSuccess]
       when request on repo is  successful 
       (repo.watchOne() is successful)''',
      build: () {
        when(() => repo.watchOne(chatBotDiary.id))
            .thenAnswer((_) => Stream.value(Right(listOf(chatBotDiary))));
        return cubit;
      },
      act: (_) => cubit.watchOneStarted(chatBotDiary.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        EntityWatcherState<ChatBot>.loadSuccess(listOf(chatBotDiary)),
      ],
      verify: (_) => repo.watchOne(chatBotDiary.id),
    );
  });
  group('watchCreatedByStarted()', () {
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [LoadFailure]
      when repo returns failure
      ''',
      build: () {
        when(() => repo.watchAllOfParentEntity(dummyUserOne.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.unexpected())));
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        return cubit;
      },
      act: (_) => cubit.watchCreatedByStarted(),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.loadFailure(CrudFailure.unexpected()),
      ],
      verify: (_) => repo.watchAllOfParentEntity(dummyUserOne.id),
    );
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [LoadSuccess]
       when request on repo is  successful 
       (repo.watchOne() is successful)''',
      build: () {
        when(() => repo.watchAllOfParentEntity(dummyUserOne.id))
            .thenAnswer((_) => Stream.value(Right(listOf(chatBotDiary))));
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        return cubit;
      },
      act: (_) => cubit.watchCreatedByStarted(),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        EntityWatcherState<ChatBot>.loadSuccess(listOf(chatBotDiary)),
      ],
      verify: (_) => repo.watchAllOfParentEntity(dummyUserOne.id),
    );
  });
  group('watchAllSubscribedStarted()', () {
    blocTest(
      '''should call repo.watchAllSubscribed() and 
      emit:
      [LoadInProgress],
      [LoadFailure]
      when repo returns failure
      ''',
      build: () {
        when(() => repo.watchAllSubscribed(dummyUserOne.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.unexpected())));
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        return cubit;
      },
      act: (_) => cubit.watchAllSubscribedStarted(),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.loadFailure(CrudFailure.unexpected()),
      ],
      verify: (_) => repo.watchAllSubscribed(dummyUserOne.id),
    );
    blocTest(
      '''should call repo.watchAllSubscribed() and 
      emit:
      [LoadInProgress],
      [LoadSuccess]
       when request on repo is  successful 
       (repo.watchOne() is successful)''',
      build: () {
        when(() => repo.watchAllSubscribed(dummyUserOne.id))
            .thenAnswer((_) => Stream.value(Right(listOf(chatBotDiary))));
        when(() => authRepo.getSignedInUserId())
            .thenAnswer((_) async => dummyUserOne.id);
        return cubit;
      },
      act: (_) => cubit.watchAllSubscribedStarted(),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        EntityWatcherState<ChatBot>.loadSuccess(listOf(chatBotDiary)),
      ],
      verify: (_) => repo.watchAllSubscribed(dummyUserOne.id),
    );
  });
  group('watchAllStarted()', () {
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [LoadFailure]
      when repo returns failure
      ''',
      build: () {
        when(() => repo.watchAll()).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.unexpected())));
        return cubit;
      },
      act: (_) => cubit.watchAllStarted(),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.loadFailure(CrudFailure.unexpected()),
      ],
      verify: (_) => repo.watchAll(),
    );
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [LoadSuccess]
       when request on repo is  successful 
       (repo.watchOne() is successful)''',
      build: () {
        when(() => repo.watchAll())
            .thenAnswer((_) => Stream.value(Right(listOf(chatBotDiary))));
        return cubit;
      },
      act: (_) => cubit.watchAllStarted(),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        EntityWatcherState<ChatBot>.loadSuccess(listOf(chatBotDiary)),
      ],
      verify: (_) => repo.watchAll(),
    );
  });
}
