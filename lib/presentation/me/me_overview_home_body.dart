// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';
import '../../injection.dart';

class MeOverviewHomeBody extends StatelessWidget {
  const MeOverviewHomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CenteredListTile(
          onTap: () => AutoRouter.of(context).push(const AccountRoute()),
          leading: const Icon(Icons.account_box),
          title: const Text('Account'),
          subtitle: const Text('Username, password, email etc.'),
        ),
        CenteredListTile(
          onTap: () async {
            final userId = await getIt<IAuthFacade>().getSignedInUserId();
            AutoRouter.of(context).push(
                ManageChatbotsOverviewRoute(context: context, userId: userId));
          },
          leading: const Icon(Icons.manage_accounts),
          title: const Text('Chatbot Editor'),
          subtitle: const Text('Manage your own chatbots'),
        ),
        CenteredListTile(
          onTap: () => AutoRouter.of(context).push(const SettingsRoute()),
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          subtitle: const Text('Language, unit etc.'),
        ),
      ],
    );
  }
}
