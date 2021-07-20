// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animator/animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/multiple_choice_picker/multiple_choice_picker_cubit.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';
import 'package:smart_chat/domain/entities/answer_item/answer_item_value.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/presentation/chat/chat_page.dart';

class MCAnswerOptionSelector extends StatelessWidget {
  final animKey = AnimatorKey<Offset>();
  MCAnswerOptionSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QarSelectorBloc, QarSelectorState>(
          listenWhen: (p, c) =>
              p.selectedQar?.id != c.selectedQar?.id &&
              c.question.type is MultipleChoice,
          listener: (context, state) {
            animKey.triggerAnimation();
          },
        ),
      ],
      child: BlocBuilder<MultipleChoicePickerCubit, MultipleChoicePickerState>(
        buildWhen: (p, c) => p.displayedItemValues != c.displayedItemValues,
        builder: (context, state) {
          return Animator<Offset>(
            triggerOnInit: true,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.ease,
            tween: Tween<Offset>(
                begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)),
            animatorKey: animKey,
            builder: (context, animatorState, child) => FractionalTranslation(
              translation: animKey.value,
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.displayedItemValues.size + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const AddNewAnswerOptionChip();
                    } else {
                      return UnselectedAnswerChip(
                          state.displayedItemValues[index - 1]);
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class UnselectedAnswerChip extends StatelessWidget {
  final AnswerItemValue answerItemBody;

  const UnselectedAnswerChip(
    this.answerItemBody, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<MultipleChoicePickerCubit>()
            .answerSelected(answerItemBody);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Colors.yellow[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MultipleChoiceAnswerText(answerItemBody.toUniqueId()),
        ),
      ),
    );
  }
}

class AddNewAnswerOptionChip extends StatelessWidget {
  const AddNewAnswerOptionChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultipleChoicePickerCubit, MultipleChoicePickerState>(
      buildWhen: (p, c) =>
          p.showAddNewAnswerOptionChip != c.showAddNewAnswerOptionChip ||
          p.textInput != c.textInput,
      builder: (context, state) {
        if (!state.showAddNewAnswerOptionChip) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () {
              context
                  .read<MultipleChoicePickerCubit>()
                  .onNewAnswerOptionClicked();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              color: Colors.yellow[200],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(state.textInput),
                    ),
                  ),
                  const Icon(
                    Icons.add,
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
