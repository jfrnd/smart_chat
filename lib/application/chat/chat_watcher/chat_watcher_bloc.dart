// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'chat_watcher_bloc.freezed.dart';
part 'chat_watcher_event.dart';
part 'chat_watcher_state.dart';

@injectable
class ChatWatcherBloc extends Bloc<ChatWatcherEvent, ChatWatcherState> {
  final IChatBotWatcherApi chatBotRepo;
  final IQuestionWatcherApi questionRepo;
  final IQarWatcherApi qarRepoWatcher;
  final IAnswerItemWatcherApi answerItemRepo;
  final IAnswerOptionWatcherApi answerOptionRepo;
  final IQarCrudRepo qarCrudRepo;
  final IAuthFacade authFacade;

  ChatWatcherBloc({
    required this.chatBotRepo,
    required this.questionRepo,
    required this.qarCrudRepo,
    required this.qarRepoWatcher,
    required this.answerItemRepo,
    required this.answerOptionRepo,
    required this.authFacade,
  }) : super(ChatWatcherState.initial());

  StreamSubscription<Either<dynamic, dynamic>>? _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ChatWatcherState> mapEventToState(
    ChatWatcherEvent event,
  ) async* {
    yield* event.map(
      watchStarted: (e) async* {
        yield state.copyWith(isLoading: true);

        await _streamSubscription?.cancel();

        _streamSubscription = CombineLatestStream.combine5(
          chatBotRepo.watchOne(e.chatBotId),
          qarRepoWatcher.watchAllVisibleOfChatBot(e.chatBotId),
          questionRepo.watchAllOfChatBot(e.chatBotId),
          answerOptionRepo.watchAllOfChatBot(e.chatBotId),
          answerItemRepo.watchAllOfChatBotAndSignedInUser(e.chatBotId),
          (
            Either<CrudFailure, KtList<ChatBot>> fOrChatBots,
            Either<CrudFailure, KtList<Qar>> fOrQars,
            Either<CrudFailure, KtList<Question>> fOrQuestions,
            Either<CrudFailure, KtList<AnswerOption>> fOrAnswerOptions,
            Either<CrudFailure, KtList<AnswerItem>> fOrAnswerItemns,
          ) {
            CrudFailure? failure;
            ChatBot? chatBot;
            KtList<Qar> qars = listOf();
            KtList<Question> questions = listOf();
            KtList<AnswerOption> answerOptions = listOf();
            KtList<AnswerItem> answerItems = listOf();

            fOrChatBots.fold(
                (f) => failure = f, (value) => chatBot = value.first());
            fOrQars.fold((f) => failure = f, (value) => qars = value);

            fOrQuestions.fold((f) => failure = f, (value) => questions = value);
            fOrAnswerOptions.fold(
                (f) => failure = f, (value) => answerOptions = value);
            fOrAnswerItemns.fold(
                (f) => failure = f, (value) => answerItems = value);

            if (failure != null) {
              return left(failure);
            } else {
              return right(
                  [chatBot, qars, questions, answerOptions, answerItems]);
            }
          },
        ).listen(
          (failureOrValues) {
            failureOrValues.fold(
              (f) => add(ChatWatcherEvent.failureReceived(f as CrudFailure)),
              (values) {
                final chatBot = values[0] as ChatBot;
                final qars = values[1] as KtList<Qar>;
                final questions = values[2] as KtList<Question>;
                final answerOptions = values[3] as KtList<AnswerOption>;
                final answerItems = values[4] as KtList<AnswerItem>;

                add(
                  ChatWatcherEvent.dataReceived(
                    chatBot,
                    qars,
                    questions,
                    answerOptions,
                    answerItems,
                  ),
                );
              },
            );
          },
        );
      },
      dataReceived: (e) async* {
        yield state.copyWith(
          isLoading: false,
          chatBot: e.chatBot,
          questions: e.questions,
          qars: e.qars,
          answerOptions:
              e.answerOptions + listOf(AnswerOption.yes(), AnswerOption.no()),
          answerItems: e.answerItems,
        );
      },
      failureReceived: (e) async* {
        yield state.copyWith(
          failure: e.failure,
          isLoading: false,
        );
      },
    );
  }
}
