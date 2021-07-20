// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/entities/qar/qar.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import '../chat_page.dart';

class QuestionMessage extends StatelessWidget {
  final Qar qar;
  final BuildContext pContext;
  const QuestionMessage({
    Key? key,
    required this.qar,
    required this.pContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      actions: [
        SlideAction(
          onTap: () {
            context
                .read<QarSelectorBloc>()
                .add(QarSelectorEvent.qarSelected(qar.id));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.replay),
            ],
          ),
        ),
        SlideAction(
          onTap: () => AutoRouter.of(context).push(
              AnalysisRoute(questionId: qar.questionId, pContext: pContext)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.list),
            ],
          ),
        ),
      ],
      child: Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.3),
        child: BubbleBox(
          direction: BubbleDirection.left,
          radius: 20,
          position: BubblePosition(top: 1),
          border: BubbleBoxBorder(color: Colors.grey, width: 0.1),
          arrowHeight: 10,
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 1,
          backgroundColor: Colors.yellow[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 10,
              runSpacing: 5,
              children: [
                BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
                  buildWhen: (p, c) =>
                      p.questions.findById(qar.questionId) !=
                      c.questions.findById(qar.questionId),
                  builder: (context, state) {
                    final question = state.questions.findById(qar.questionId);
                    if (question == null) {
                      return const Text('Fatal Error: Question not found');
                    } else {
                      return Text(
                        question.getTranslationAsString(
                          LanguageCode.fromLocale(
                            Localizations.localeOf(context),
                          ),
                        ),
                        textAlign: TextAlign.start,
                      );
                    }
                  },
                ),
                Timestamp(
                    dateTime: qar.visibleSince ?? qar.createdAt,
                    color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
