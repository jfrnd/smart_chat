// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:smart_chat/application/chat/multiple_choice_picker/multiple_choice_picker_cubit.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/presentation/chat/chat_page.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Expanded(
      child: GestureDetector(
        onTap: () {
          focusNode.requestFocus();
          SystemChannels.textInput.invokeMethod('TextInput.show');
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SelectedAnswerOptions(),
                CurrentTextInput(focusNode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentTextInput extends HookWidget {
  final FocusNode focusNode;

  const CurrentTextInput(this.focusNode, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final curText = context.watch<MultipleChoicePickerCubit>().state.textInput;
    final textEditingController = useTextEditingController();

    useEffect(() {
      textEditingController.text = curText;
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
    }, [curText]);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 20),
        child: IntrinsicWidth(
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            maxLength: AnswerOptionBody.ANSWER_OPTION_BODY_MAX_LENGTH,
            onChanged: (value) {
              context
                  .read<MultipleChoicePickerCubit>()
                  .curTextInputChanged(value);
            },
          ),
        ),
      ),
    );
  }
}

class SelectedAnswerOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultipleChoicePickerCubit, MultipleChoicePickerState>(
      buildWhen: (p, c) => p.selectedItemValues != c.selectedItemValues,
      builder: (context, state) {
        final options = List.generate(
          state.selectedItemValues.size,
          (index) {
            return SelectedAnswerChip(state.selectedItemValues[index]);
          },
        );
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: options,
        );
      },
    );
  }
}

class SelectedAnswerChip extends StatelessWidget {
  const SelectedAnswerChip(
    this.answerItemBody, {
    Key? key,
  }) : super(key: key);

  final AnswerItemValue answerItemBody;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Chip(
        backgroundColor: Colors.yellow[200],
        label: MultipleChoiceAnswerText(answerItemBody.toUniqueId()),
        onDeleted: () {
          context
              .read<MultipleChoicePickerCubit>()
              .answerUnselected(answerItemBody);
        },
      ),
    );
  }
}
