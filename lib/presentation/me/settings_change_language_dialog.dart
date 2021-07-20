// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:smart_chat/application/settings/language_selector/language_selector_cubit.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/utils/locale_extensions.dart';

class SettingsChangeLanguageDialog extends StatelessWidget {
  final Locale initLocale;

  const SettingsChangeLanguageDialog({Key? key, required this.initLocale})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageSelectorCubit()..localeChanged(initLocale),
      child: BlocBuilder<LanguageSelectorCubit, LanguageSelectorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.language),
              actions: [
                IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      context.read<SettingsBloc>().add(
                          SettingsEvent.savedToSharedPreferences(state.locale));
                      AutoRouter.of(context).pop();
                    })
              ],
            ),
            body: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.read<LanguageSelectorCubit>().localeChanged(
                        AppLocalizations.supportedLocales[index]);
                  },
                  leading:
                      Text(AppLocalizations.supportedLocales[index].toFlag()),
                  title: Text(AppLocalizations.supportedLocales[index]
                      .toForeignNotation()),
                  trailing:
                      AppLocalizations.supportedLocales[index] == state.locale
                          ? const Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : const Text(''),
                );
              },
              itemCount: AppLocalizations.supportedLocales.length,
            ),
          );
        },
      ),
    );
  }
}
