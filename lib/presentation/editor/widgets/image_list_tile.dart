// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:smart_chat/application/editors/chatbot_image_editor/chatbot_image_editor_bloc.dart';
import 'package:smart_chat/application/watchers/chatbot_watcher_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';
import '../../../injection.dart';

class ImageListTile extends StatelessWidget {
  const ImageListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatBot = context.select((ChatBotWatcherCubit bloc) =>
        (bloc.state is LoadSuccess)
            ? (bloc.state as LoadSuccess).entityList[0]
            : ChatBot.empty()) as ChatBot;

    return BlocProvider(
      create: (context) => getIt<ChatBotImageEditorBloc>()
        ..add(ChatBotImageEditorEvent.showImageStarted(chatBot.imageUrl)),
      child: BlocBuilder<ChatBotImageEditorBloc, ChatBotImageEditorState>(
        builder: (context, state) {
          return InkWell(
            onTap: () => context.read<ChatBotImageEditorBloc>().add(
                  ChatBotImageEditorEvent.onImageClicked(chatBot),
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.map(
                initial: (_) => Container(),
                updateImageInProgress: (_) => Material(
                    elevation: 3,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 1 / 3 * 0.9,
                          width:
                              MediaQuery.of(context).size.height * 1 / 3 * 0.9,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    )),
                showImage: (state) => ChatBotImage(
                  imageUrl: state.url,
                  placeholderIconData: Icons.add_photo_alternate_rounded,
                  height: MediaQuery.of(context).size.height * 1 / 3,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
