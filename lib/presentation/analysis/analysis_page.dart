// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/presentation/chat/chat_page.dart';
import 'package:smart_chat/utils/date_time_extensions.dart';

class AnalysisPage extends StatelessWidget {
  final UniqueId questionId;
  final BuildContext pContext;

  const AnalysisPage({
    Key? key,
    required this.questionId,
    required this.pContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ChatWatcherBloc>(pContext),
      child: BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
        builder: (context, state) {
          final question = state.questions.findById(questionId);
          final answerItems = state.answerItems.filterByQuestionId(questionId);
          if (question == null) {
            return Container();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  question.getTranslationAsString(
                    LanguageCode.fromLocale(
                      Localizations.localeOf(context),
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: answerItems.size,
                        itemBuilder: (context, index) {
                          final item = answerItems[index];
                          return ListTile(
                            leading: Text(item.validOn.toDisplayedString()),
                            title: AnswerText(item.value, question),
                          );
                        },
                      ),
                    ),
                  ),
                  Chart(
                    question: question,
                    items: answerItems,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final Question question;
  final KtList<AnswerItem> items;
  const Chart({
    Key? key,
    required this.question,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return question.type.maybeMap(
      orElse: () => Container(),
      yesNo: (_) => YesNoPie(items: items),
    );
  }
}

class YesNoPie extends StatelessWidget {
  final KtList<AnswerItem> items;

  const YesNoPie({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalCount = items.size;
    final yesCount =
        items.filter((item) => item.value == AnswerItemValue.yes()).size;
    final yesRatio = yesCount / totalCount;
    final noCount =
        items.filter((item) => item.value == AnswerItemValue.no()).size;
    final noRatio = noCount / totalCount;

    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: yesRatio,
                      color: Colors.blue,
                      title: yesRatio.toStringAsFixed(2),
                    ),
                    PieChartSectionData(
                      value: noRatio,
                      color: Colors.grey,
                      title: noRatio.toStringAsFixed(2),
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      AnswerOption.yes().getTranslationAsString(
                        LanguageCode.fromLocale(
                          Localizations.localeOf(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      AnswerOption.no().getTranslationAsString(
                        LanguageCode.fromLocale(
                          Localizations.localeOf(context),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
