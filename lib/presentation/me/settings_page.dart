// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';
import 'package:smart_chat/utils/locale_extensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CenteredListTile(
            onTap: () => AutoRouter.of(context).push(
                SettingsChangeLanguageDialog(
                    initLocale:
                        Locale(AppLocalizations.of(context)!.localeName))),
            leading: Text(Locale(
                    getIt<SharedPreferences>().getString('LOCALE') ??
                        Localizations.localeOf(context).languageCode)
                .toFlag()),
            subtitle: Text(Locale(
                    getIt<SharedPreferences>().getString('LOCALE') ??
                        Localizations.localeOf(context).languageCode)
                .toLanguage(context)),
            title: Text(AppLocalizations.of(context)!.language),
            trailing: const Icon(Icons.edit),
          ),
          CenteredListTile(
            onTap: () => {},
            leading: const Icon(Icons.perm_scan_wifi_outlined),
            title: const Text("Unit"),
            subtitle: const Text("metric"),
            trailing: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
