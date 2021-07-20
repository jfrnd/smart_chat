// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

// Project imports:
import 'package:smart_chat/application/auth/auth_bloc.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import '../../injection.dart';
import 'notification_manager.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<AuthBloc>()..add(const AuthEvent.watchAuthState())),
        BlocProvider(
          create: (context) => getIt<SettingsBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final appLocale = context.watch<SettingsBloc>().state.appLocale;
          getIt<NotificationManager>().configureFirebaseMessaging(context);
          return OverlaySupport(
            child: ListTileTheme(
              iconColor: Colors.black,
              child: MaterialApp.router(
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: appLocale,
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                title: 'SmartChat',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  primaryColor: ThemeData.light().primaryColor,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
