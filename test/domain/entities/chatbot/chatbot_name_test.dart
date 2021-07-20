// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/value_failures.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';

void main() {
  group('instantiation', () {
    test(
      'should instantiate as ValueFailure when input has too many characters',
      () {
        // arrange
        final input = StringBuffer();
        for (int i = 0; i <= ChatBotName.CHATBOT_NAME_MAX_LENGTH; i++) {
          input.write('1');
        }
        // act
        final result = ChatBotName(input.toString());
        // assert
        expect(
            result.value,
            equals(Left(TooLongString(listOf(
              input.toString(),
              input.toString().length,
              ChatBotName.CHATBOT_NAME_MAX_LENGTH,
            )))));
      },
    );

    test(
      'should instantiate as ValueFailure when input has multiple lines',
      () {
        // arrange
        const input = 'Multi \n line';
        // act
        final result = ChatBotName(input);
        // assert
        expect(result.value, equals(const Left(MultipleLines())));
      },
    );

    test(
      'should instantiate as ValueFailure when input is empty',
      () {
        // arrange
        const input = '';
        // act
        final result = ChatBotName(input);
        // assert
        expect(result.value, equals(const Left(EmptyString())));
      },
    );

    test(
      'should instantiate as valid Object when input is valid',
      () {
        // arrange
        const input = 'Diary';
        // act
        final result = ChatBotName(input);
        // assert
        expect(result.value, equals(const Right(input)));
      },
    );
  });
}
