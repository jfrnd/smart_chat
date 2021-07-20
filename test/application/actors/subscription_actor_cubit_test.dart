// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/actors/subscription/subscription_actor_cubit.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';

class MockISubscriptionCrudRepo extends Mock implements ISubscriptionCrudRepo {}

void main() {
  late MockISubscriptionCrudRepo repo;
  late SubscriptionActorCubit cubit;

  setUp(() {
    repo = MockISubscriptionCrudRepo();
    cubit = SubscriptionActorCubit(repo);
  });

  tearDown(
    () {
      cubit.close();
      reset(repo);
    },
  );

  group('subscribed()', () {
    //TODO subscribed()
  });
  group('unSubscribed()', () {
    //TODO unSubscribed()
  });
}
