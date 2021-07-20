// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';

part 'qar_selector_bloc.freezed.dart';
part 'qar_selector_state.dart';
part 'qar_selector_event.dart';

class QarSelectorBloc extends Bloc<QarSelectorEvent, QarSelectorState> {
  final ChatWatcherBloc chatWatcherBloc;

  StreamSubscription<KtPair<ChatWatcherState, QarSelectorState>>?
      streamSubscription;

  @override
  Future<void> close() async {
    await streamSubscription?.cancel();
    return super.close();
  }

  QarSelectorBloc({
    required this.chatWatcherBloc,
  }) : super(QarSelectorState.initial()) {
    streamSubscription = CombineLatestStream.combine2(
        chatWatcherBloc.stream.startWith(chatWatcherBloc.state),
        stream,
        (ChatWatcherState chatWatcherState, QarSelectorState state) =>
            KtPair(chatWatcherState, state)).listen(
      (pair) {
        if (pair.first.failure == null && state.selectedQar != null) {
          add(QarSelectorEvent.filterChatWatcherStateByQar(state.selectedQar!));
        }
      },
    );
  }

  @override
  Stream<QarSelectorState> mapEventToState(QarSelectorEvent event) async* {
    yield* event.map(
      filterChatWatcherStateByQar: (e) async* {
        final chatWatcherState = chatWatcherBloc.state;

        final qar = chatWatcherState.qars.findById(e.qar.id)!;

        final question = chatWatcherState.questions.findById(qar.questionId)!;

        final answerOptions = chatWatcherState.answerOptions
            .filter((it) => it.questionId == question.id);

        final answerItems = chatWatcherState.answerItems
            .filter((it) => it.questionId == question.id);

        final savedAnswerItems = answerItems.filter((it) => it.qarId == qar.id);

        final possibleItemValues = answerItems.itemBodies
            .distinct()
            .plus(answerOptions
                .asAnswerItemBodies(question.type)
                .filterNot((it) => answerItems.itemBodies.contains(it)))
            .minus(savedAnswerItems.itemBodies);

        yield state.copyWith(
          selectedQar: qar,
          question: question,
          answerOptions: answerOptions,
          savedAnswerItems: savedAnswerItems,
          possibleItemValues: possibleItemValues,
        );
      },
      mostRecentQarSelected: (e) async* {
        final mostRecentQar =
            chatWatcherBloc.state.qars.maxBy((it) => it.createdAt);
        add(QarSelectorEvent.qarSelected(mostRecentQar!.id));
      },
      nextQarSelected: (e) async* {
        final curQar =
            chatWatcherBloc.state.qars.findById(state.selectedQar!.id)!;
        final nextQar = chatWatcherBloc.state.qars
            .find((qar) => qar.createdAt.isAfter(curQar.createdAt));
        if (nextQar != null) {
          add(QarSelectorEvent.qarSelected(nextQar.id));
        }
      },
      qarSelected: (e) async* {
        if (e.qarId != state.selectedQar?.id) {
          final qar = chatWatcherBloc.state.qars.findById(e.qarId);
          if (qar != null) {
            add(QarSelectorEvent.filterChatWatcherStateByQar(qar));
          }
        }
      },
      newSessionCreated: (e) async* {
        chatWatcherBloc.qarCrudRepo
            .createSession(chatBotId: chatWatcherBloc.state.chatBot.id);
      },
    );
  }
}
