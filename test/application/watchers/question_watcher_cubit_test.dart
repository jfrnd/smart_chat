// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../fixtures/chatbots/diary/questions_diary.dart';

class MockIQuestionWatcherApi extends Mock implements IQuestionWatcherApi {}

void main() {
  late QuestionWatcherCubit cubit;
  late MockIQuestionWatcherApi repo;

  setUp(() {
    repo = MockIQuestionWatcherApi();
    cubit = QuestionWatcherCubit(repo);
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
        when(() => repo.watchOne(questionDay.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.unexpected())));
        return cubit;
      },
      act: (_) => cubit.watchOneStarted(questionDay.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.loadFailure(CrudFailure.unexpected()),
      ],
      verify: (_) => repo.watchOne(questionDay.id),
    );
    blocTest(
      '''should call repo.watchOne() and 
      emit:
      [LoadInProgress],
      [Deleted]
      when repo returns doesNotExist
       ''',
      build: () {
        when(() => repo.watchOne(questionDay.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.doesNotExist())));
        return cubit;
      },
      act: (_) => cubit.watchOneStarted(questionDay.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.deleted(),
      ],
      verify: (_) => repo.watchOne(questionDay.id),
    );
    blocTest(
      '''should call repo.watchOne() and 
      emit:
      [LoadInProgress],
      [LoadSuccess]
       when request on repo is  successful 
       (repo.watchOne() is successful)''',
      build: () {
        when(() => repo.watchOne(questionDay.id))
            .thenAnswer((_) => Stream.value(Right(listOf(questionDay))));
        return cubit;
      },
      act: (_) => cubit.watchOneStarted(questionDay.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        EntityWatcherState<Question>.loadSuccess(listOf(questionDay)),
      ],
      verify: (_) => repo.watchOne(questionDay.id),
    );
  });
  group('watchAllOfStarted()', () {
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [LoadFailure]
      when repo returns failure
      ''',
      build: () {
        when(() => repo.watchAllOfParentEntity(chatBotDiary.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.unexpected())));
        return cubit;
      },
      act: (_) => cubit.watchAllOfChatBotStarted(chatBotDiary.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.loadFailure(CrudFailure.unexpected()),
      ],
      verify: (_) => repo.watchAllOfParentEntity(chatBotDiary.id),
    );
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [Deleted]
      when repo returns doesNotExist
       ''',
      build: () {
        when(() => repo.watchAllOfParentEntity(chatBotDiary.id)).thenAnswer(
            (_) => Stream.value(const Left(CrudFailure.doesNotExist())));
        return cubit;
      },
      act: (_) => cubit.watchAllOfChatBotStarted(chatBotDiary.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        const EntityWatcherState.deleted(),
      ],
      verify: (_) => repo.watchAllOfParentEntity(chatBotDiary.id),
    );
    blocTest(
      '''should call repo.watchAllOfParentEntity() and 
      emit:
      [LoadInProgress],
      [LoadSuccess]
       when request on repo is  successful 
       (repo.watchOne() is successful)''',
      build: () {
        when(() => repo.watchAllOfParentEntity(chatBotDiary.id))
            .thenAnswer((_) => Stream.value(Right(listOf(questionDay))));
        return cubit;
      },
      act: (_) => cubit.watchAllOfChatBotStarted(chatBotDiary.id),
      expect: () => [
        const EntityWatcherState.loadInProgress(),
        EntityWatcherState<Question>.loadSuccess(listOf(questionDay)),
      ],
      verify: (_) => repo.watchAllOfParentEntity(chatBotDiary.id),
    );
  });
}
