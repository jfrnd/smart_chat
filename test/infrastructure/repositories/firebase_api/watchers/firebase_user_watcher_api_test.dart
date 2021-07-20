// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/watcher/firebase_user_watcher_api.dart';
import '../../../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';
import '../../../../fixtures/user.dart';

void main() {
  late FakeFirebaseFirestore fs;

  late FireBaseUserWatcherApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();

    repo = FireBaseUserWatcherApi(fs);

    await fs.populateWithUser(dummyUserOne);
  });

  group('watchOne()', () {
    test(
      'should stream a list containing only one user',
      () async {
        // act
        final stream = repo.watchOne(dummyUserOne.id);
        // assert
        expectLater(stream,
            emits(right<CrudFailure, KtList<User>>(listOf(dummyUserOne))));
      },
    );
    test(
      'should stream CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final stream = repo.watchOne(UniqueId());
        // assert
        expectLater(
            stream,
            emits(left<CrudFailure, KtList<User>>(
                const CrudFailure.doesNotExist())));
      },
    );
  });

  group('watchOfChatBot()', () {
    test(
      'should stream a list containing the creator of chatBotDiary',
      () async {
        // arrange
        await fs.populateWithChatBot(chatBotDiary);
        // act
        final stream = repo.watchOfChatBot(chatBotDiary.id);
        // assert
        expectLater(stream,
            emits(right<CrudFailure, KtList<User>>(listOf(dummyUserOne))));
      },
    );
  });
}
