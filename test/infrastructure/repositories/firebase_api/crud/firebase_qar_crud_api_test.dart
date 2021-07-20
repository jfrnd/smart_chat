// Package imports:
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/repositories/firebase_api/crud/firebase_qar_crud_api.dart';
import '../../../../fixtures/chatbots/diary/qars_diary.dart';
import '../../../../fixtures/mock_firebase_extensions.dart';

void main() {
  late FakeFirebaseFirestore fs;
  late FireBaseQarCrudApi repo;

  setUp(() async {
    fs = FakeFirebaseFirestore();
    repo = FireBaseQarCrudApi(fs);

    await fs.populateWithQar(qarDayMonday);
  });

  group('readOne()', () {
    test(
      'should return qarDayMonday',
      () async {
        // act
        final res = await repo.readOne(qarDayMonday.id);
        // assert
        expectLater(res, right<CrudFailure, Qar>(qarDayMonday));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readOne(UniqueId());
        // assert
        expectLater(
            res, left<CrudFailure, Qar>(const CrudFailure.doesNotExist()));
      },
    );
  });
  group('createOnDB()', () {
    test(
      '''should add qar to fs and return right(unit)''',
      () async {
        // act
        final response = await repo.createOnDB(qarDayTuesday);
        // assert
        final qarOnFs = await fs.getQarOrNull(
          userId: qarDayTuesday.createdBy,
          chatBotId: qarDayTuesday.chatBotId,
          qarId: qarDayTuesday.id,
        );
        expectLater(response, equals(const Right(unit)));
        expectLater(qarOnFs, equals(qarDayTuesday));
      },
    );
  });
  group('updateOnDB()', () {
    test(
      'should update qar on fs and return right(unit)',
      () async {
        // arrange
        final updatedDomainQar = qarDayMonday.makeAnswered();
        // act
        final response = await repo.updateOnDB(updatedDomainQar);
        // assert
        final qarOnFs = await fs.getQarOrNull(
          userId: qarDayMonday.createdBy,
          chatBotId: qarDayMonday.chatBotId,
          qarId: qarDayMonday.id,
        );

        expectLater(response, equals(const Right(unit)));
        expectLater(qarOnFs, equals(updatedDomainQar));
      },
    );
  });
  group('deleteFromDB()', () {
    test(
      'should delete qar from fs and return right(unit)',
      () async {
        // arrange
        await fs.populateWithQar(qarDayTuesday);
        // act
        final response = await repo.deleteFromDB(qarDayMonday);
        // assert
        final doc = await fs.getQarOrNull(
          userId: qarDayMonday.createdBy,
          chatBotId: qarDayMonday.chatBotId,
          qarId: qarDayMonday.id,
        );

        final doc2 = await fs.getQarOrNull(
          userId: qarDayTuesday.createdBy,
          chatBotId: qarDayTuesday.chatBotId,
          qarId: qarDayTuesday.id,
        );

        expectLater(doc == null, true);
        expectLater(doc2 == null, false);
        expectLater(response, equals(const Right(unit)));
      },
    );
  });
  group('readAllOfSession()', () {
    test(
      'should return qarDayMonday and qarSleepMonday',
      () async {
        // arrange
        fs.populateWithQar(qarSleepMonday);
        fs.populateWithQar(qarDayTuesday);

        // act
        final res =
            await repo.readAllOfSession(UniqueId.fromUniqueString(MONDAY));
        // assert
        expectLater(
            res,
            right<CrudFailure, KtList<Qar>>(
                listOf(qarDayMonday, qarSleepMonday)));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readAllOfSession(UniqueId());
        // assert
        expectLater(
            res, left<CrudFailure, Qar>(const CrudFailure.doesNotExist()));
      },
    );
  });
  group('readBySessionIdAndPosition()', () {
    test(
      'should return qarDayMonday',
      () async {
        // act
        final res = await repo.readBySessionIdAndPosition(
            qarDayMonday.sessionId, qarDayMonday.position);
        // assert
        expectLater(res, right<CrudFailure, Qar>(qarDayMonday));
      },
    );

    test(
      'should return CrudFailure.doesNotExist() when document does not exist',
      () async {
        // act
        final res = await repo.readBySessionIdAndPosition(UniqueId(), 0);
        // assert
        expectLater(
            res, left<CrudFailure, Qar>(const CrudFailure.doesNotExist()));
      },
    );
  });
}
