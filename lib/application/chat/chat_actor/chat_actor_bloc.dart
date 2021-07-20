// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'chat_actor_bloc.freezed.dart';
part 'chat_actor_event.dart';
part 'chat_actor_state.dart';

@injectable
class ChatActorBloc extends Bloc<ChatActorEvent, ChatActorState> {
  final IAnswerItemCrudRepo answerItemCrudRepo;
  final IAnswerOptionCrudRepo answerOptionCrudRepo;

  ChatActorBloc({
    required this.answerItemCrudRepo,
    required this.answerOptionCrudRepo,
  }) : super(ChatActorState.initial());

  Future<Either<Unit, AnswerOption>> answerOptionCreated(
    Qar qar,
    LanguageCode languageCode,
    AnswerOptionBody body,
  ) async {
    add(const ChatActorEvent.answerOptionCreatedStarted());

    final newAnswerOption = AnswerOption.createWithQar(
      qar: qar,
      languageCode: languageCode,
      body: body,
    );

    return answerOptionCrudRepo.create(newAnswerOption).then(
          (failureOrUnit) => failureOrUnit.fold(
            (failure) {
              add(ChatActorEvent.answerOptionCreatedFinished(failure: failure));
              return const Left(unit);
            },
            (answerOption) {
              add(const ChatActorEvent.answerOptionCreatedFinished());
              return Right(answerOption);
            },
          ),
        );
  }

  @override
  Stream<ChatActorState> mapEventToState(ChatActorEvent event) async* {
    yield* event.map(
      answerOptionCreatedStarted: (e) async* {
        yield state.copyWith(
          failure: null,
          isSaving: true,
        );
      },
      answerOptionCreatedFinished: (e) async* {
        yield state.copyWith(
          failure: e.failure,
          isSaving: false,
        );
      },
      answerItemDeleted: (e) async* {
        yield state.copyWith(
          failure: null,
        );

        CrudFailure? saveFailure;

        await answerItemCrudRepo.delete(e.answerItemId).then(
              (failureOrUnit) => failureOrUnit.fold(
                (failure) => saveFailure = failure,
                (_) => null,
              ),
            );

        yield state.copyWith(
          failure: saveFailure,
        );
      },
      answerItemsCreated: (e) async* {
        if (!state.isSaving) {
          CrudFailure? saveFailure;

          yield state.copyWith(
            failure: null,
            isSaving: true,
          );

          final answerItems = e.itemValues.map(
            (val) => AnswerItem.createWithQar(qar: e.qar, value: val),
          );

          await answerItemCrudRepo.createMultiple(answerItems).then(
                (failureOrItems) => failureOrItems.fold(
                  (failure) => saveFailure = failure,
                  (_) => null,
                ),
              );
          yield state.copyWith(
            failure: saveFailure,
            isSaving: false,
          );
        }
      },
    );
  }
}
