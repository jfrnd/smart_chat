// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension FlagParsing on Locale {
  String toFlag() {
    switch (languageCode) {
      case 'en':
        return '🇬🇧';
      case 'de':
        return '🇩🇪';
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'zh':
        return '🇨🇳';
      case 'ko':
        return '🇰🇷';
      case 'ja':
        return '🇯🇵';
      case 'tr':
        return '🇹🇷';
      default:
        return '🌎';
    }
  }

  String toLanguage(BuildContext context) {
    switch (languageCode) {
      case 'en':
        return AppLocalizations.of(context)!.english;
      case 'de':
        return AppLocalizations.of(context)!.german;
      case 'fr':
        return AppLocalizations.of(context)!.french;
      case 'es':
        return AppLocalizations.of(context)!.spanish;
      case 'it':
        return AppLocalizations.of(context)!.italian;
      case 'pt':
        return AppLocalizations.of(context)!.portuguese;
      case 'ru':
        return AppLocalizations.of(context)!.russian;
      case 'zh':
        return AppLocalizations.of(context)!.chinese;
      case 'ko':
        return AppLocalizations.of(context)!.korean;
      case 'ja':
        return AppLocalizations.of(context)!.japanese;
      case 'tr':
        return AppLocalizations.of(context)!.turkish;
      default:
        return '🌎';
    }
  }

  String toForeignNotation() {
    switch (languageCode) {
      case 'en':
        return 'english';
      case 'de':
        return 'deutsch';
      case 'fr':
        return 'français';
      case 'es':
        return 'español';
      case 'it':
        return 'italiano';
      case 'pt':
        return 'português';
      case 'ru':
        return 'ру́сский';
      case 'zh':
        return '简体中文';
      case 'ko':
        return '한국어';
      case 'ja':
        return '日本語';
      case 'tr':
        return 'türkçe';
      default:
        return 'unknon language';
    }
  }
}
