// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/application/chat/numeric_slider/slider_cubit.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatActorBloc, ChatActorState>(
      buildWhen: (p, c) => c.isSaving != p.isSaving,
      builder: (context, state) {
        return SizedBox(
          height: 50,
          width: 50,
          child: state.isSaving
              ? const CircularProgressIndicator()
              : ClipOval(
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => context.read<SliderCubit>().saved(),
                      child: Icon(
                        Icons.send,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}


