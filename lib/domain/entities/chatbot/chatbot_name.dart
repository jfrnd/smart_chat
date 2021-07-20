// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:smart_chat/domain/core/value_failure.dart';
import 'package:smart_chat/domain/core/value_object.dart';
import 'package:smart_chat/domain/core/valueobjects/value_validators.dart';

class ChatBotName extends StringValueObject {
  @override
  final Either<ValueFailure, String> value;

  static const int CHATBOT_NAME_MAX_LENGTH = 20;

  factory ChatBotName(String input) {
    return ChatBotName._(validateNotEmptySingleLineMaxLength(
        input.trim(), CHATBOT_NAME_MAX_LENGTH));
  }
  
  static ChatBotName genericCreate({String? input}) =>
      input != null ? ChatBotName(input) : ChatBotName.empty();

  const ChatBotName._(this.value);

  factory ChatBotName.empty() => ChatBotName('');
}
