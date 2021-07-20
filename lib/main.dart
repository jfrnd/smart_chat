// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/core/app_widget.dart';
import 'package:smart_chat/utils/app_bloc_observer.dart';
import 'package:smart_chat/utils/logger.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  logger.d('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    if (inDebug) return ErrorWidget(details.exception);
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception}',
        style: const TextStyle(color: Colors.red),
        textDirection: TextDirection.ltr,
      ),
    );
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureInjection(Environment.prod);
  // ! only uncomment when there is data with invalid data schema in cache
  // await getIt<FirebaseFirestore>().clearPersistence();
  Bloc.observer = AppBlocObserver();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await getIt<FirebaseMessaging>().setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(AppWidget());
}

//TroubleShooting Build_runner
//Delete all "import 'file" occurrences

// File -> Invalidate Caches/Restart

// flutter clean
// flutter pub get
// flutter pub run build_runner clean
// flutter pub run build_runner watch --delete-conflicting-outputs

// Center(
//   child: Builder(builder: (context) {
//     if (authState is Authenticated) {
//       return Text(authState.user.id.getOrCrash());
//     } else {
//       return const Text('123');
//     }
//   }),
// ),
// Center(child: authState is Authenticated ? Text(authState.user.id.getOrCrash() ) : const Text('123')),
