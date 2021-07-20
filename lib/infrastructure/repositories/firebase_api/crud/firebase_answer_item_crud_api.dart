// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/infrastructure/core/firestore_helpers.dart';
import 'package:smart_chat/infrastructure/dto/answer_item_dto.dart';

@LazySingleton(as: IAnswerItemCrudApi)
class FireBaseAnswerItemCrudApi implements IAnswerItemCrudApi {
  final FirebaseFirestore fs;

  FireBaseAnswerItemCrudApi(this.fs);

  @override
  Future<Either<CrudFailure, AnswerItem>> readOne(UniqueId answerItemId) async {
    try {
      return fs.queryOfAnswerItem(answerItemId: answerItemId).get().then(
        (snapshot) {
          final docs = snapshot.docs;
          if (docs.isNotEmpty) {
            return right(AnswerItemDto.fromFireStore(docs.first).toDomain());
          } else {
            return left(const CrudFailure.doesNotExist());
          }
        },
      );
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> createOnDB(AnswerItem item) async {
    try {
      await fs
          .answerItemDocOf(
            userId: item.createdBy,
            chatBotId: item.chatBotId,
            itemId: item.id,
          )
          .set(AnswerItemDto.fromDomain(item).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> updateOnDB(AnswerItem item) async {
    try {
      await fs
          .answerItemDocOf(
              userId: item.createdBy,
              chatBotId: item.chatBotId,
              itemId: item.id)
          .update(AnswerItemDto.fromDomain(item).toFireStore());
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }

  @override
  Future<Either<CrudFailure, Unit>> deleteFromDB(AnswerItem answerItem) async {
    try {
      await fs
          .answerItemDocOf(
              userId: answerItem.createdBy,
              chatBotId: answerItem.chatBotId,
              itemId: answerItem.id)
          .delete();
      return right(unit);
    } catch (e) {
      return left(convertToCrudFailure(e));
    }
  }
}
