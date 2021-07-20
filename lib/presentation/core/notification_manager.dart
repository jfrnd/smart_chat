// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:overlay_support/overlay_support.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/presentation/core/widgets/chatbot_image.dart';
import 'package:smart_chat/utils/logger.dart';

@lazySingleton
class NotificationManager {
  StreamSubscription? onMessageSubscription;
  StreamSubscription? onMessageOpenedAppSubscription;

  Future<void> configureFirebaseMessaging(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          logger.d('onBackgroundMessage');
        }
      },
    );

    await onMessageOpenedAppSubscription?.cancel();
    onMessageOpenedAppSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        logger.d('onMessageOpenedApp');
      },
    );

    await onMessageSubscription?.cancel();
    onMessageSubscription = FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        logger.d('message received');
        final notification = message.notification;
        if (notification != null) {
          showSimpleNotification(
            ListTile(
              dense: true,
              title: Text(
                notification.title.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                notification.body.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              leading: ChatBotImage(
                imageUrl: ImageUrl(message.data.values.first as String),
                height: 40,
                width: 40,
                placeholderIconData: Icons.photo,
              ),
              tileColor: Theme.of(context).primaryColorDark,
              onTap: () {},
            ),
            contentPadding: EdgeInsets.zero,
            position: NotificationPosition.bottom,
            background: Colors.transparent,
            duration: const Duration(seconds: 5),
            slideDismissDirection: DismissDirection.horizontal,
          );
        }
      },
    );
  }
}
