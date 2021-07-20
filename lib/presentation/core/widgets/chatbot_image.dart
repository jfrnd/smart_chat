// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/injection.dart';

class ChatBotImage extends StatelessWidget {
  const ChatBotImage({
    Key? key,
    required this.imageUrl,
    required this.placeholderIconData,
    required this.width,
    required this.height,
  }) : super(key: key);

  final ImageUrl imageUrl;
  final double width;
  final double height;
  final IconData placeholderIconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Builder(
        builder: (context) {
          if (imageUrl.isEmpty()) {
            return SizedBox(
              width: width,
              height: height,
              child: Icon(
                placeholderIconData,
                color: Colors.grey,
                size: height * 0.5,
              ),
            );
          } else {
            return CachedNetworkImage(
              cacheManager: getIt<DefaultCacheManager>(),
              fit: BoxFit.contain,
              width: width,
              height: height,
              imageUrl: imageUrl.toString(),
              placeholder: (context, url) => Center(
                child: SizedBox(
                  height: height * 0.9,
                  width: height * 0.9,
                  child: const CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => SizedBox(
                width: width,
                height: height,
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: height * 0.5,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
