// Package imports:
import 'package:auto_route/annotations.dart';
import 'package:smart_chat/presentation/analysis/analysis_page.dart';
import 'package:smart_chat/presentation/chat/chat_page.dart';
import 'package:smart_chat/presentation/discover/discover_details_page.dart';
import 'package:smart_chat/presentation/editor/pages/entity_editor_page.dart';
import 'package:smart_chat/presentation/editor/pages/manage_entities_overview_page.dart';
import 'package:smart_chat/presentation/home/home_page.dart';
import 'package:smart_chat/presentation/me/settings_change_language_dialog.dart';
import 'package:smart_chat/presentation/me/account_page.dart';
import 'package:smart_chat/presentation/me/settings_page.dart';
import 'package:smart_chat/presentation/sign_in/sign_in_page.dart';
import 'package:smart_chat/presentation/splash/splash_page.dart';

// Project imports:

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: HomePage),
    // CHAT
    AutoRoute(page: ChatPage),
    AutoRoute(page: AnalysisPage),
    // EDITOR
    AutoRoute(page: ChatBotEditorPage),
    AutoRoute(page: QuestionEditorPage),
    AutoRoute(page: AnswerOptionEditorPage),
    AutoRoute(page: ManageChatbotsOverviewPage),
    AutoRoute(page: ManageQuestionsOverviewPage),
    AutoRoute(page: ManageAnswerOptionsOverviewPage),
    // DISCOVER
    AutoRoute(page: DiscoverDetailsPage),
    // ME
    AutoRoute(page: SettingsPage),
    AutoRoute(page: AccountPage),
    AutoRoute(page: SettingsChangeLanguageDialog, fullscreenDialog: true),
  ],
)
class $AppRouter {}
