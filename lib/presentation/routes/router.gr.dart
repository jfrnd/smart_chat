// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../domain/core/valueobjects/unique_id.dart' as _i14;
import '../analysis/analysis_page.dart' as _i7;
import '../chat/chat_page.dart' as _i6;
import '../discover/discover_details_page.dart' as _i10;
import '../editor/pages/entity_editor_page.dart' as _i8;
import '../editor/pages/manage_entities_overview_page.dart' as _i9;
import '../home/home_page.dart' as _i5;
import '../me/account_page.dart' as _i12;
import '../me/settings_change_language_dialog.dart' as _i13;
import '../me/settings_page.dart' as _i11;
import '../sign_in/sign_in_page.dart' as _i4;
import '../splash/splash_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SplashPage();
        }),
    SignInRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.SignInPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i5.HomePage();
        }),
    ChatRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ChatRouteArgs>();
          return _i6.ChatPage(key: args.key, chatBotId: args.chatBotId);
        }),
    AnalysisRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AnalysisRouteArgs>();
          return _i7.AnalysisPage(
              key: args.key,
              questionId: args.questionId,
              pContext: args.pContext);
        }),
    ChatBotEditorRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ChatBotEditorRouteArgs>();
          return _i8.ChatBotEditorPage(
              key: args.key, chatBotId: args.chatBotId);
        }),
    QuestionEditorRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<QuestionEditorRouteArgs>();
          return _i8.QuestionEditorPage(
              key: args.key,
              questionId: args.questionId,
              chatBotId: args.chatBotId,
              pContext: args.pContext);
        }),
    AnswerOptionEditorRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AnswerOptionEditorRouteArgs>();
          return _i8.AnswerOptionEditorPage(
              key: args.key,
              answerOptionId: args.answerOptionId,
              pContext: args.pContext);
        }),
    ManageChatbotsOverviewRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ManageChatbotsOverviewRouteArgs>();
          return _i9.ManageChatbotsOverviewPage(
              key: args.key, context: args.context, userId: args.userId);
        }),
    ManageQuestionsOverviewRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<ManageQuestionsOverviewRouteArgs>();
              return _i9.ManageQuestionsOverviewPage(
                  key: args.key,
                  context: args.context,
                  chatBotId: args.chatBotId);
            }),
    ManageAnswerOptionsOverviewRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<ManageAnswerOptionsOverviewRouteArgs>();
              return _i9.ManageAnswerOptionsOverviewPage(
                  key: args.key,
                  context: args.context,
                  questionId: args.questionId,
                  chatBotId: args.chatBotId);
            }),
    DiscoverDetailsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DiscoverDetailsRouteArgs>();
          return _i10.DiscoverDetailsPage(
              key: args.key, chatBotId: args.chatBotId);
        }),
    SettingsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i11.SettingsPage();
        }),
    AccountRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i12.AccountPage();
        }),
    SettingsChangeLanguageDialog.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<SettingsChangeLanguageDialogArgs>();
              return _i13.SettingsChangeLanguageDialog(
                  key: args.key, initLocale: args.initLocale);
            },
            fullscreenDialog: true)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(SignInRoute.name, path: '/sign-in-page'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i1.RouteConfig(ChatRoute.name, path: '/chat-page'),
        _i1.RouteConfig(AnalysisRoute.name, path: '/analysis-page'),
        _i1.RouteConfig(ChatBotEditorRoute.name, path: '/chat-bot-editor-page'),
        _i1.RouteConfig(QuestionEditorRoute.name,
            path: '/question-editor-page'),
        _i1.RouteConfig(AnswerOptionEditorRoute.name,
            path: '/answer-option-editor-page'),
        _i1.RouteConfig(ManageChatbotsOverviewRoute.name,
            path: '/manage-chatbots-overview-page'),
        _i1.RouteConfig(ManageQuestionsOverviewRoute.name,
            path: '/manage-questions-overview-page'),
        _i1.RouteConfig(ManageAnswerOptionsOverviewRoute.name,
            path: '/manage-answer-options-overview-page'),
        _i1.RouteConfig(DiscoverDetailsRoute.name,
            path: '/discover-details-page'),
        _i1.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i1.RouteConfig(AccountRoute.name, path: '/account-page'),
        _i1.RouteConfig(SettingsChangeLanguageDialog.name,
            path: '/settings-change-language-dialog')
      ];
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/sign-in-page');

  static const String name = 'SignInRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

class ChatRoute extends _i1.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({_i2.Key? key, required _i14.UniqueId chatBotId})
      : super(name,
            path: '/chat-page',
            args: ChatRouteArgs(key: key, chatBotId: chatBotId));

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.chatBotId});

  final _i2.Key? key;

  final _i14.UniqueId chatBotId;
}

class AnalysisRoute extends _i1.PageRouteInfo<AnalysisRouteArgs> {
  AnalysisRoute(
      {_i2.Key? key,
      required _i14.UniqueId questionId,
      required _i2.BuildContext pContext})
      : super(name,
            path: '/analysis-page',
            args: AnalysisRouteArgs(
                key: key, questionId: questionId, pContext: pContext));

  static const String name = 'AnalysisRoute';
}

class AnalysisRouteArgs {
  const AnalysisRouteArgs(
      {this.key, required this.questionId, required this.pContext});

  final _i2.Key? key;

  final _i14.UniqueId questionId;

  final _i2.BuildContext pContext;
}

class ChatBotEditorRoute extends _i1.PageRouteInfo<ChatBotEditorRouteArgs> {
  ChatBotEditorRoute({_i2.Key? key, required _i14.UniqueId chatBotId})
      : super(name,
            path: '/chat-bot-editor-page',
            args: ChatBotEditorRouteArgs(key: key, chatBotId: chatBotId));

  static const String name = 'ChatBotEditorRoute';
}

class ChatBotEditorRouteArgs {
  const ChatBotEditorRouteArgs({this.key, required this.chatBotId});

  final _i2.Key? key;

  final _i14.UniqueId chatBotId;
}

class QuestionEditorRoute extends _i1.PageRouteInfo<QuestionEditorRouteArgs> {
  QuestionEditorRoute(
      {_i2.Key? key,
      required _i14.UniqueId questionId,
      required _i14.UniqueId chatBotId,
      required _i2.BuildContext pContext})
      : super(name,
            path: '/question-editor-page',
            args: QuestionEditorRouteArgs(
                key: key,
                questionId: questionId,
                chatBotId: chatBotId,
                pContext: pContext));

  static const String name = 'QuestionEditorRoute';
}

class QuestionEditorRouteArgs {
  const QuestionEditorRouteArgs(
      {this.key,
      required this.questionId,
      required this.chatBotId,
      required this.pContext});

  final _i2.Key? key;

  final _i14.UniqueId questionId;

  final _i14.UniqueId chatBotId;

  final _i2.BuildContext pContext;
}

class AnswerOptionEditorRoute
    extends _i1.PageRouteInfo<AnswerOptionEditorRouteArgs> {
  AnswerOptionEditorRoute(
      {_i2.Key? key,
      required _i14.UniqueId answerOptionId,
      required _i2.BuildContext pContext})
      : super(name,
            path: '/answer-option-editor-page',
            args: AnswerOptionEditorRouteArgs(
                key: key, answerOptionId: answerOptionId, pContext: pContext));

  static const String name = 'AnswerOptionEditorRoute';
}

class AnswerOptionEditorRouteArgs {
  const AnswerOptionEditorRouteArgs(
      {this.key, required this.answerOptionId, required this.pContext});

  final _i2.Key? key;

  final _i14.UniqueId answerOptionId;

  final _i2.BuildContext pContext;
}

class ManageChatbotsOverviewRoute
    extends _i1.PageRouteInfo<ManageChatbotsOverviewRouteArgs> {
  ManageChatbotsOverviewRoute(
      {_i2.Key? key,
      required _i2.BuildContext context,
      required _i14.UniqueId userId})
      : super(name,
            path: '/manage-chatbots-overview-page',
            args: ManageChatbotsOverviewRouteArgs(
                key: key, context: context, userId: userId));

  static const String name = 'ManageChatbotsOverviewRoute';
}

class ManageChatbotsOverviewRouteArgs {
  const ManageChatbotsOverviewRouteArgs(
      {this.key, required this.context, required this.userId});

  final _i2.Key? key;

  final _i2.BuildContext context;

  final _i14.UniqueId userId;
}

class ManageQuestionsOverviewRoute
    extends _i1.PageRouteInfo<ManageQuestionsOverviewRouteArgs> {
  ManageQuestionsOverviewRoute(
      {_i2.Key? key,
      required _i2.BuildContext context,
      required _i14.UniqueId chatBotId})
      : super(name,
            path: '/manage-questions-overview-page',
            args: ManageQuestionsOverviewRouteArgs(
                key: key, context: context, chatBotId: chatBotId));

  static const String name = 'ManageQuestionsOverviewRoute';
}

class ManageQuestionsOverviewRouteArgs {
  const ManageQuestionsOverviewRouteArgs(
      {this.key, required this.context, required this.chatBotId});

  final _i2.Key? key;

  final _i2.BuildContext context;

  final _i14.UniqueId chatBotId;
}

class ManageAnswerOptionsOverviewRoute
    extends _i1.PageRouteInfo<ManageAnswerOptionsOverviewRouteArgs> {
  ManageAnswerOptionsOverviewRoute(
      {_i2.Key? key,
      required _i2.BuildContext context,
      required _i14.UniqueId questionId,
      required _i14.UniqueId chatBotId})
      : super(name,
            path: '/manage-answer-options-overview-page',
            args: ManageAnswerOptionsOverviewRouteArgs(
                key: key,
                context: context,
                questionId: questionId,
                chatBotId: chatBotId));

  static const String name = 'ManageAnswerOptionsOverviewRoute';
}

class ManageAnswerOptionsOverviewRouteArgs {
  const ManageAnswerOptionsOverviewRouteArgs(
      {this.key,
      required this.context,
      required this.questionId,
      required this.chatBotId});

  final _i2.Key? key;

  final _i2.BuildContext context;

  final _i14.UniqueId questionId;

  final _i14.UniqueId chatBotId;
}

class DiscoverDetailsRoute extends _i1.PageRouteInfo<DiscoverDetailsRouteArgs> {
  DiscoverDetailsRoute({_i2.Key? key, required _i14.UniqueId chatBotId})
      : super(name,
            path: '/discover-details-page',
            args: DiscoverDetailsRouteArgs(key: key, chatBotId: chatBotId));

  static const String name = 'DiscoverDetailsRoute';
}

class DiscoverDetailsRouteArgs {
  const DiscoverDetailsRouteArgs({this.key, required this.chatBotId});

  final _i2.Key? key;

  final _i14.UniqueId chatBotId;
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

class AccountRoute extends _i1.PageRouteInfo {
  const AccountRoute() : super(name, path: '/account-page');

  static const String name = 'AccountRoute';
}

class SettingsChangeLanguageDialog
    extends _i1.PageRouteInfo<SettingsChangeLanguageDialogArgs> {
  SettingsChangeLanguageDialog({_i2.Key? key, required _i2.Locale initLocale})
      : super(name,
            path: '/settings-change-language-dialog',
            args: SettingsChangeLanguageDialogArgs(
                key: key, initLocale: initLocale));

  static const String name = 'SettingsChangeLanguageDialog';
}

class SettingsChangeLanguageDialogArgs {
  const SettingsChangeLanguageDialogArgs({this.key, required this.initLocale});

  final _i2.Key? key;

  final _i2.Locale initLocale;
}
