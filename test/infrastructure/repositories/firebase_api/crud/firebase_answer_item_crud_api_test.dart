// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_answer_item_crud_api.dart';
import '../../../../fixtures/chatbots/diary/answer_items_diary.dart';
import '../../../../fixtures/chatbots/diary/answer_options_diary.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseAnswerItemCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseAnswerItemCrudApi(fs);
  });

  group('readOne()', () {
    test(
      'should return qarDayMonday',
      () async {
        // arrange
        fs.populateWithAnswerItem(answerItemDayGoodMonday);
        // act
        final res = await repo.readOne(answerItemDayGoodMonday.id);
        // assert
        expectLater(
            res, right<CrudFailure, AnswerItem>(answerItemDayGoodMonday));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readOne(UniqueId());
        // assert
        expectLater(res,
            left<CrudFailure, AnswerItem>(const CrudFailure.doesNotExist()));
      },
    );
  });
  group('createOnDB()', () {
    test(
      '''should add item to fs and return right(unit)''',
      () async {
        // act
        final response = await repo.createOnDB(answerItemDayBadTuesday);
        // assert
        final answerItemOnFs = await fs.getAnswerItemOrNull(
          userId: answerItemDayBadTuesday.createdBy,
          chatBotId: answerItemDayBadTuesday.chatBotId,
          answerItemId: answerItemDayBadTuesday.id,
        );
        expectLater(response, equals(const Right(unit)));
        expectLater(answerItemOnFs, equals(answerItemDayBadTuesday));
      },
    );
  });
  group('updateOnDB()', () {
    test(
      'should update item on fs and return right(unit)',
      () async {
        // arrange
        fs.populateWithAnswerItem(answerItemDayBadTuesday);

        final updatedDomainAnswerItem = answerItemDayBadTuesday.copyWith(
          value: AnswerItemValue.fromAnswerOptionId(answerOptionDayGood.id),
        );
        // act
        final response = await repo.updateOnDB(updatedDomainAnswerItem);
        // assert
        final answerItemOnFs = await fs.getAnswerItemOrNull(
          userId: answerItemDayBadTuesday.createdBy,
          chatBotId: answerItemDayBadTuesday.chatBotId,
          answerItemId: answerItemDayBadTuesday.id,
        );

        expectLater(response, equals(const Right(unit)));
        expectLater(answerItemOnFs, equals(updatedDomainAnswerItem));
      },
    );
  });
  group('deleteFromDB()', () {
    test(
      'should delete item from fs and return right(unit)',
      () async {
        // arrange
        fs.populateWithAnswerItem(answerItemDayBadTuesday);
        fs.populateWithAnswerItem(answerItemDayGoodMonday);
        // act
        final response = await repo.deleteFromDB(answerItemDayBadTuesday);

        // assert

        final doc = await fs.getAnswerItemOrNull(
          userId: answerItemDayBadTuesday.createdBy,
          chatBotId: answerItemDayBadTuesday.chatBotId,
          answerItemId: answerItemDayBadTuesday.id,
        );
        final doc2 = await fs.getAnswerItemOrNull(
          userId: answerItemDayGoodMonday.createdBy,
          chatBotId: answerItemDayGoodMonday.chatBotId,
          answerItemId: answerItemDayGoodMonday.id,
        );

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
}
