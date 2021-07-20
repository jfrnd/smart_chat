// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chat/application/actors/subscription/subscription_actor_cubit.dart';

// Project imports:
import 'package:smart_chat/application/auth/auth_bloc.dart';
import 'package:smart_chat/application/home_navigator/home_navigator_cubit.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/chat/chats_overview_home_body.dart';
import 'package:smart_chat/presentation/discover/discover_overview_home_body.dart';
import 'package:smart_chat/presentation/home/bottom_nav_bar.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import '../me/me_overview_home_body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<SettingsBloc>().add(
          SettingsEvent.initialized(
              localeAsString: getIt<SharedPreferences>().getString('LOCALE')),
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeNavigatorCubit>()..chatsSelected(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => {
          state.maybeMap(
              unauthenticated: (_) {
                AutoRouter.of(context).pop();
                AutoRouter.of(context).replace(const SignInRoute());
              },
              orElse: () {})
        },
        child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.home),
              ),
              drawer: const HomeDrawer(),
              body: state.map(
                initial: (_) => Container(),
                chatsSelected: (_) => const ChatsOverviewHomeBody(),
                discoverSelected: (_) => const DiscoverOverviewHomeBody(),
                meSelected: (_) => const MeOverviewHomeBody(),
              ),
              bottomNavigationBar: const BottomNavBar(),
            );
          },
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(child: Text(AppLocalizations.of(context)!.appname)),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () {
              context.read<AuthBloc>().add(const AuthEvent.signedOut());
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(AppLocalizations.of(context)!.about),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
