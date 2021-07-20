// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'question_type.freezed.dart';

const YES_NO = 'yesNo';
const NUMERIC = 'numeric';
const TIME = 'time';
const MULTIPLE_CHOICE = 'multipleChoice';
const OPEN = 'open';

final possibleQuestionTypes = listOf(
  const QuestionType.yesNo(),
  const QuestionType.numeric(),
  const QuestionType.time(),
  const QuestionType.multipleChoice(),
);

@freezed
class QuestionType with _$QuestionType {
  const factory QuestionType.yesNo() = YesNo;
  const factory QuestionType.numeric() = Numeric;
  const factory QuestionType.time() = Time;
  const factory QuestionType.multipleChoice() = MultipleChoice;
  const factory QuestionType.open() = Open;

  factory QuestionType.fromString(String type) {
    switch (type) {
      case YES_NO:
        return const QuestionType.yesNo();
      case NUMERIC:
        return const QuestionType.numeric();
      case TIME:
        return const QuestionType.time();
      case MULTIPLE_CHOICE:
        return const QuestionType.multipleChoice();
      case OPEN:
        return const QuestionType.open();
      default:
        return const QuestionType.open();
    }
  }
}

extension QuestionTypeX on QuestionType {
  String asString() {
    return map(
      yesNo: (_) => YES_NO,
      numeric: (_) => NUMERIC,
      time: (_) => TIME,
      multipleChoice: (_) => MULTIPLE_CHOICE,
      open: (_) => OPEN,
    );
  }

  String toDisplayedString() {
    return map(
      yesNo: (_) => 'Yes/No',
      numeric: (_) => 'Numeric',
      time: (_) => 'Time',
      multipleChoice: (_) => 'Multiple Choice',
      open: (_) => 'open question',
    );
  }

  IconData asIconData() {
    return map(
      yesNo: (_) => Icons.rule_folder_outlined,
      numeric: (_) => Icons.timer_10,
      time: (_) => Icons.timer,
      multipleChoice: (_) => Icons.ballot,
      open: (_) => Icons.ac_unit,
    );
  }

  Icon asIcon() {
    return map(
      yesNo: (_) => Icon(
        asIconData(),
        color: Colors.lime,
      ),
      numeric: (_) => Icon(
        asIconData(),
        color: Colors.purple,
      ),
      time: (_) => Icon(
        asIconData(),
        color: Colors.orange,
      ),
      multipleChoice: (_) => Icon(
        asIconData(),
        color: Colors.lightBlue,
      ),
      open: (_) => Icon(
        asIconData(),
      ),
    );
  }
}
