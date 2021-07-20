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
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/core/valueobjects/time_value.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'chats_overview_watcher_bloc.freezed.dart';
part 'chats_overview_watcher_event.dart';
part 'chats_overview_watcher_state.dart';

@injectable
class ChatsOverviewWatcherBloc extends Bloc<ChatsOverviewWatcherEvent, ChatsOverviewWatcherState> {
  final IChatBotWatcherApi chatBotWatcher;
  final IQarWatcherApi qarRepoWatcher;
  final IAnswerItemCrudRepo answerItemRepoCrud;
  final IQuestionCrudRepo questionRepoCrud;
  final IAnswerOptionCrudRepo answerOptionRepoCrud;
  final IAuthRepo authRepo;
  final SettingsBloc settingsBloc;

  ChatsOverviewWatcherBloc({
    required this.chatBotWatcher,
    required this.qarRepoWatcher,
    required this.questionRepoCrud,
    required this.answerItemRepoCrud,
    required this.answerOptionRepoCrud,
    required this.authRepo,
    required this.settingsBloc,
  }) : super(ChatsOverviewWatcherState.initial());

  StreamSubscription<Either<CrudFailure, KtList<ChatBot>>>?
      _chatBotStreamSubscription;

  StreamSubscription<KtMap<UniqueId, Either<CrudFailure, Qar?>>>?
      _qarStreamSubscription;

  @override
  Future<void> close() async {
    await _chatBotStreamSubscription?.cancel();
    await _qarStreamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ChatsOverviewWatcherState> mapEventToState(
    ChatsOverviewWatcherEvent event,
  ) async* {
    yield* event.map(
      watchStarted: (e) async* {
        yield state.copyWith(isLoading: true);

        final userId = await authRepo.getSignedInUserId();

        await _chatBotStreamSubscription?.cancel();

        _chatBotStreamSubscription = chatBotWatcher
            .watchAllSubscribed(userId)
            .listen((failureOrChatBots) {
          failureOrChatBots.fold(
            (f) => add(ChatsOverviewWatcherEvent.failureReceived(f)),
            (chatBots) => add(ChatsOverviewWatcherEvent.chatBotsReceived(chatBots)),
          );
        });
      },
      chatBotsReceived: (e) async* {
        yield state.copyWith(
          chatBots: e.chatBots,
          isLoading: e.chatBots.isEmpty() ? false : state.isLoading,
        );

        final userId = await authRepo.getSignedInUserId();

        await _qarStreamSubscription?.cancel();

        _qarStreamSubscription = qarRepoWatcher
            .watchUnreadOrMostRecentQarOfChatBots(e.chatBots.ids, userId)
            .listen((qars) async {
          add(ChatsOverviewWatcherEvent.qarsReceived(qars));
        });
      },

      failureReceived: (e) async* {
        yield state.copyWith(
          isLoading: false,
          failure: e.failure,
        );
      },
      qarsReceived: (e) async* {
        final isAnswered = e.idsToQars.mapValues(
          (entry) => entry.value.fold(
            (failure) => true,
            (qar) => qar != null ? qar.isAnswered : true,
          ),
        );

        final dateTime = e.idsToQars.mapValues(
          (entry) => entry.value.fold(
            (failure) => null,
            (qar) => qar?.createdAt,
          ),
        );

        final tasks =
            e.idsToQars.map((entry) => readMostRecentMessage(entry)).asList();

        final lastMessages = await Future.wait(tasks)
            .then((mapEntries) => KtMap.from(Map.fromEntries(mapEntries)));

        yield state.copyWith(
          isLoading: false,
          isAnswered: isAnswered,
          lastMessages: lastMessages,
          dateTime: dateTime,
        );
      },
    );
  }

  Future<MapEntry<UniqueId, String>> readMostRecentMessage(
      KtMapEntry<UniqueId, Either<CrudFailure, Qar?>> mapEntry) async {
    final chatBotId = mapEntry.key;

    return mapEntry.value.fold(
      (f) => MapEntry(chatBotId, f.toString()),
      (qar) async {
        if (qar == null) {
          return MapEntry(chatBotId, '');
        } else {
          return questionRepoCrud.readOne(qar.questionId).then(
                (failureOrQuestion) => failureOrQuestion.fold(
                  (f) => MapEntry(chatBotId, f.toString()),
                  (question) async {
                    if (qar.hasNoAnswerItems) {
                      final languageCode = LanguageCode.fromLocale(
                        settingsBloc.state.appLocale ?? const Locale('en'),
                      );
                      return MapEntry(
                        chatBotId,
                        question.getTranslationAsString(languageCode),
                      );
                    } else {
                      return readAnswerMessage(qar, question, chatBotId);
                    }
                  },
                ),
              );
        }
      },
    );
  }

  Future<MapEntry<UniqueId, String>> readAnswerMessage(
      Qar qar, Question question, UniqueId chatBotId) async {
    return answerItemRepoCrud
        .readOne(
          qar.answerItemIds.last(),
        )
        .then(
          (failureOrItem) => failureOrItem.fold(
            (f) => MapEntry(chatBotId, f.toString()),
            (item) {
              return question.type.map(
                yesNo: (_) => readYesNoAnswerMessage(item.value, chatBotId),
                numeric: (_) => MapEntry(
                  chatBotId,
                  NumericValue.fromItemValue(item.value).toDisplayedString(
                    question.unit,
                    question.digits.getOrCrash(),
                  ),
                ),
                time: (_) => MapEntry(
                  chatBotId,
                  TimeValue.fromItemValue(item.value).toDisplayedString(),
                ),
                multipleChoice: (_) => readMultipleChoiceAnswerMessage(
                    item.value.toUniqueId(), chatBotId),
                open: (_) => MapEntry(chatBotId, ''),
              );
            },
          ),
        );
  }

  Future<MapEntry<UniqueId, String>> readMultipleChoiceAnswerMessage(
      UniqueId answerOptionId, UniqueId chatBotId) {
    final languageCode = LanguageCode.fromLocale(
        settingsBloc.state.appLocale ?? const Locale('en'));
    return answerOptionRepoCrud.readOne(answerOptionId).then(
          (failureOrOption) => failureOrOption.fold(
            (f) => MapEntry(chatBotId, f.toString()),
            (option) => MapEntry(
              chatBotId,
              option.getTranslationAsString(languageCode),
            ),
          ),
        );
  }

  MapEntry<UniqueId, String> readYesNoAnswerMessage(
      AnswerItemValue itemValue, UniqueId chatBotId) {
    final languageCode = LanguageCode.fromLocale(
        settingsBloc.state.appLocale ?? const Locale('en'));
    if (itemValue == AnswerItemValue.yes()) {
      return MapEntry(
        chatBotId,
        AnswerOption.yes().getTranslationAsString(languageCode),
      );
    } else {
      return MapEntry(
        chatBotId,
        AnswerOption.no().getTranslationAsString(languageCode),
      );
    }
  }
}
