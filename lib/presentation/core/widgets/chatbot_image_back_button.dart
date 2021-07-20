// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';

class ChatBotImageBackButton extends StatelessWidget {
  final ImageUrl imageUrl;

  const ChatBotImageBackButton({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).pop();
      },
      child: Row(
        children: [
          const Icon(Icons.arrow_back),
          ChatBotImage(
              imageUrl: imageUrl,
              height: MediaQuery.of(context).size.height * 1 / 24,
              width: MediaQuery.of(context).size.height * 1 / 24,
              placeholderIconData: Icons.photo),
        ],
      ),
    );
  }
}


