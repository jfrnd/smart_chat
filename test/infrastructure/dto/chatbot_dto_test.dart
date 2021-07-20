// Package imports:
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/chatbot_dto.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';
import '../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;

  setUp(() async {
    fs = FakeFirebaseFirestore();
  });

  group('fromDomain()', () {
    test(
      'should return DTO',
      () async {
        // act
        final result = ChatBotDto.fromDomain(chatBotDiary);
        // assert
        expect(result, equals(chatBotDiaryAsDto));
      },
    );
  });
  group('toDomain()', () {
    test(
      'should return Domain Object',
      () {
        // act
        final result = chatBotDiaryAsDto.toDomain();
        // assert
        expect(result, equals(chatBotDiary));
      },
    );
  });
  group('fromFireStore()', () {
    test(
      'should return DTO',
      () async {
        // arrange
        await fs.populateWithChatBot(chatBotDiary);
        final snapshot = await fs.getChatBotDoc(chatBotDiary.id);

        // act
        final res = ChatBotDto.fromFireStore(snapshot);
        // assert
        expect(res, equals(chatBotDiaryAsDto));
      },
    );
  });
  group('toFirestore()', () {
    test(
      'should return firestore map',
      () {
        // act
        final res = chatBotDiaryAsDto.toFireStore();
        // assert
        expect(res, equals(chatBotDiaryAsFirebaseMap));
      },
    );
  });
}
