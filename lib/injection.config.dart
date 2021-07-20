// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:cloud_functions/cloud_functions.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_messaging/firebase_messaging.dart' as _i7;
import 'package:firebase_storage/firebase_storage.dart' as _i8;
import 'package:flutter_cache_manager/flutter_cache_manager.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:image_picker/image_picker.dart' as _i30;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i34;

import 'application/actors/answer_option_actor_cubit.dart' as _i58;
import 'application/actors/chatbot_actor_cubit.dart' as _i47;
import 'application/actors/question_actor_cubit.dart' as _i56;
import 'application/actors/subscription/subscription_actor_cubit.dart' as _i35;
import 'application/auth/auth_bloc.dart' as _i46;
import 'application/chat/chat_actor/chat_actor_bloc.dart' as _i60;
import 'application/chat/chat_watcher/chat_watcher_bloc.dart' as _i62;
import 'application/chat/chats_overview_watcher/chats_overview_watcher_bloc.dart'
    as _i63;
import 'application/editors/answer_option_editor_cubit.dart' as _i59;
import 'application/editors/chatbot_editor_cubit.dart' as _i48;
import 'application/editors/chatbot_image_editor/chatbot_image_editor_bloc.dart'
    as _i49;
import 'application/editors/question_editor_cubit.dart' as _i57;
import 'application/home_navigator/home_navigator_cubit.dart' as _i10;
import 'application/settings/language_selector/language_selector_cubit.dart'
    as _i31;
import 'application/settings/settings_bloc.dart' as _i42;
import 'application/sign_in_form/sign_in_form_bloc.dart' as _i43;
import 'application/watchers/answer_option_watcher_cubit.dart' as _i36;
import 'application/watchers/chatbot_watcher_cubit.dart' as _i61;
import 'application/watchers/question_watcher_cubit.dart' as _i33;
import 'application/watchers/subscription_watcher_cubit.dart' as _i44;
import 'application/watchers/user_watcher_cubit.dart' as _i45;
import 'domain/core/i_meta_data_provider.dart' as _i20;
import 'domain/repositories/api/i_auth_facade.dart' as _i16;
import 'domain/repositories/api/i_crud_api.dart' as _i11;
import 'domain/repositories/api/i_watcher_api.dart' as _i14;
import 'domain/repositories/auth/i_auth_repo.dart' as _i37;
import 'domain/repositories/crud/i_crud_repo.dart' as _i25;
import 'infrastructure/core/firebase_injectable_module.dart' as _i65;
import 'infrastructure/core/injectable_module.dart' as _i64;
import 'infrastructure/repositories/client/auth/client_auth_repo.dart' as _i38;
import 'infrastructure/repositories/client/crud/client_answer_item_crud_repo.dart'
    as _i50;
import 'infrastructure/repositories/client/crud/client_answer_option_crud_repo.dart'
    as _i52;
import 'infrastructure/repositories/client/crud/client_chatbot_crud_repo.dart'
    as _i39;
import 'infrastructure/repositories/client/crud/client_qar_crud_repo.dart'
    as _i40;
import 'infrastructure/repositories/client/crud/client_question_crud_repo.dart'
    as _i55;
import 'infrastructure/repositories/client/crud/client_subscription_crud_repo.dart'
    as _i26;
import 'infrastructure/repositories/client/crud/client_user_crud_repo.dart'
    as _i28;
import 'infrastructure/repositories/firebase_api/auth/firebase_auth_facade.dart'
    as _i17;
import 'infrastructure/repositories/firebase_api/crud/firebase_answer_item_crud_api.dart'
    as _i12;
import 'infrastructure/repositories/firebase_api/crud/firebase_answer_option_crud_api.dart'
    as _i13;
import 'infrastructure/repositories/firebase_api/crud/firebase_chatbot_crud_api.dart'
    as _i18;
import 'infrastructure/repositories/firebase_api/crud/firebase_image_crud_api.dart'
    as _i19;
import 'infrastructure/repositories/firebase_api/crud/firebase_qar_crud_api.dart'
    as _i21;
import 'infrastructure/repositories/firebase_api/crud/firebase_question_repo_crud_api.dart'
    as _i22;
import 'infrastructure/repositories/firebase_api/crud/firebase_subscription_crud_api.dart'
    as _i24;
import 'infrastructure/repositories/firebase_api/crud/firebase_user_crud_api.dart'
    as _i27;
import 'infrastructure/repositories/firebase_api/watcher/firebase_answer_item_watcher_api.dart'
    as _i51;
import 'infrastructure/repositories/firebase_api/watcher/firebase_answer_option_watcher_api.dart'
    as _i15;
import 'infrastructure/repositories/firebase_api/watcher/firebase_chatbot_watcher_api.dart'
    as _i53;
import 'infrastructure/repositories/firebase_api/watcher/firebase_qar_watcher_api.dart'
    as _i54;
import 'infrastructure/repositories/firebase_api/watcher/firebase_question_watcher_api.dart'
    as _i23;
import 'infrastructure/repositories/firebase_api/watcher/firebase_subscription_watcher_api.dart'
    as _i41;
import 'infrastructure/repositories/firebase_api/watcher/firebase_user_watcher_api.dart'
    as _i29;
import 'presentation/core/notification_manager.dart'
    as _i32; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.DefaultCacheManager>(() => injectableModule.cacheManger);
  gh.lazySingleton<_i4.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i6.FirebaseFunctions>(
      () => firebaseInjectableModule.functions);
  gh.lazySingleton<_i7.FirebaseMessaging>(
      () => firebaseInjectableModule.messaging);
  gh.lazySingleton<_i8.FirebaseStorage>(() => firebaseInjectableModule.storage);
  gh.lazySingleton<_i9.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.factory<_i10.HomeNavigatorCubit>(() => _i10.HomeNavigatorCubit());
  gh.lazySingleton<_i11.IAnswerItemCrudApi>(
      () => _i12.FireBaseAnswerItemCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.IAnswerOptionCrudApi>(
      () => _i13.FireBaseAnswerOptionCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i14.IAnswerOptionWatcherApi>(
      () => _i15.FireBaseAnswerOptionWatcherApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i16.IAuthFacade>(() => _i17.FirebaseAuthFacade(
      get<_i4.FirebaseAuth>(), get<_i9.GoogleSignIn>()));
  gh.lazySingleton<_i11.IChatBotCrudApi>(
      () => _i18.FireBaseChatBotCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.IImageCrudApi>(
      () => _i19.FireBaseImageCrudApi(get<_i8.FirebaseStorage>()));
  gh.lazySingleton<_i20.IMetaDataProvider>(() => _i20.MetaDataProvider());
  gh.lazySingleton<_i11.IQarCrudApi>(
      () => _i21.FireBaseQarCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.IQuestionCrudApi>(
      () => _i22.FireBaseQuestionCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i14.IQuestionWatcherApi>(
      () => _i23.FireBaseQuestionWatcherApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i11.ISubscriptionCrudApi>(
      () => _i24.FireBaseSubscriptionCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i25.ISubscriptionCrudRepo>(() =>
      _i26.ClientSubscriptionCrud(
          get<_i20.IMetaDataProvider>(),
          get<_i11.ISubscriptionCrudApi>(),
          get<_i11.IChatBotCrudApi>(),
          get<_i16.IAuthFacade>()));
  gh.lazySingleton<_i11.IUserCrudApi>(
      () => _i27.FireBaseUserCrudApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i25.IUserCrudRepo>(() => _i28.ClientUserCrud(
      get<_i20.IMetaDataProvider>(), get<_i11.IUserCrudApi>()));
  gh.lazySingleton<_i14.IUserWatcherApi>(
      () => _i29.FireBaseUserWatcherApi(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i30.ImagePicker>(() => injectableModule.imagePicker);
  gh.factory<_i31.LanguageSelectorCubit>(() => _i31.LanguageSelectorCubit());
  gh.lazySingleton<_i32.NotificationManager>(() => _i32.NotificationManager());
  gh.factory<_i33.QuestionWatcherCubit>(
      () => _i33.QuestionWatcherCubit(get<_i14.IQuestionWatcherApi>()));
  await gh.factoryAsync<_i34.SharedPreferences>(() => injectableModule.prefs,
      preResolve: true);
  gh.factory<_i35.SubscriptionActorCubit>(
      () => _i35.SubscriptionActorCubit(get<_i25.ISubscriptionCrudRepo>()));
  gh.factory<_i36.AnswerOptionWatcherCubit>(
      () => _i36.AnswerOptionWatcherCubit(get<_i14.IAnswerOptionWatcherApi>()));
  gh.lazySingleton<_i37.IAuthRepo>(() => _i38.ClientAuthRepo(
      authFacade: get<_i16.IAuthFacade>(),
      metaDataProvider: get<_i20.IMetaDataProvider>(),
      crudApi: get<_i11.IUserCrudApi>(),
      preferences: get<_i34.SharedPreferences>()));
  gh.lazySingleton<_i25.IChatBotCrudRepo>(() => _i39.ClientChatBotCrud(
      get<_i37.IAuthRepo>(),
      get<_i20.IMetaDataProvider>(),
      get<_i11.IChatBotCrudApi>(),
      get<_i11.IImageCrudApi>(),
      get<_i11.IUserCrudApi>()));
  gh.lazySingleton<_i25.IQarCrudRepo>(() => _i40.ClientQarCrud(
      get<_i37.IAuthRepo>(),
      get<_i20.IMetaDataProvider>(),
      get<_i11.IQarCrudApi>(),
      get<_i11.IQuestionCrudApi>()));
  gh.lazySingleton<_i14.ISubscriptionWatcherApi>(() =>
      _i41.FireBaseSubscriptionWatcherApi(
          get<_i5.FirebaseFirestore>(), get<_i37.IAuthRepo>()));
  gh.lazySingleton<_i42.SettingsBloc>(
      () => _i42.SettingsBloc(get<_i34.SharedPreferences>()));
  gh.factory<_i43.SignInFormBloc>(
      () => _i43.SignInFormBloc(get<_i37.IAuthRepo>()));
  gh.factory<_i44.SubscriptionWatcherCubit>(
      () => _i44.SubscriptionWatcherCubit(get<_i14.ISubscriptionWatcherApi>()));
  gh.factory<_i45.UserWatcherCubit>(() => _i45.UserWatcherCubit(
      get<_i14.IUserWatcherApi>(), get<_i37.IAuthRepo>()));
  gh.factory<_i46.AuthBloc>(() => _i46.AuthBloc(get<_i37.IAuthRepo>()));
  gh.factory<_i47.ChatBotActorCubit>(
      () => _i47.ChatBotActorCubit(get<_i25.IChatBotCrudRepo>()));
  gh.factory<_i48.ChatBotEditorCubit>(
      () => _i48.ChatBotEditorCubit(get<_i25.IChatBotCrudRepo>()));
  gh.factory<_i49.ChatBotImageEditorBloc>(() => _i49.ChatBotImageEditorBloc(
      get<_i30.ImagePicker>(),
      get<_i25.IChatBotCrudRepo>(),
      get<_i11.IImageCrudApi>(),
      get<_i3.DefaultCacheManager>()));
  gh.lazySingleton<_i25.IAnswerItemCrudRepo>(() => _i50.ClientAnswerItemCrud(
      get<_i37.IAuthRepo>(),
      get<_i20.IMetaDataProvider>(),
      get<_i11.IAnswerItemCrudApi>(),
      get<_i11.IQarCrudApi>(),
      get<_i11.IQuestionCrudApi>()));
  gh.lazySingleton<_i14.IAnswerItemWatcherApi>(() =>
      _i51.FireBaseAnswerItemWatcherApi(
          get<_i5.FirebaseFirestore>(), get<_i37.IAuthRepo>()));
  gh.lazySingleton<_i25.IAnswerOptionCrudRepo>(() =>
      _i52.ClientAnswerOptionCrud(get<_i37.IAuthRepo>(),
          get<_i20.IMetaDataProvider>(), get<_i11.IAnswerOptionCrudApi>()));
  gh.lazySingleton<_i14.IChatBotWatcherApi>(() =>
      _i53.FireBaseChatBotWatcherApi(
          get<_i5.FirebaseFirestore>(), get<_i14.ISubscriptionWatcherApi>()));
  gh.lazySingleton<_i14.IQarWatcherApi>(() => _i54.FireBaseQarWatcherApi(
      get<_i5.FirebaseFirestore>(),
      get<_i37.IAuthRepo>(),
      get<_i14.IChatBotWatcherApi>(),
      get<_i14.IQuestionWatcherApi>()));
  gh.lazySingleton<_i25.IQuestionCrudRepo>(() => _i55.ClientQuestionCrud(
      get<_i37.IAuthRepo>(),
      get<_i20.IMetaDataProvider>(),
      get<_i25.IAnswerOptionCrudRepo>(),
      get<_i11.IQuestionCrudApi>()));
  gh.factory<_i56.QuestionActorCubit>(
      () => _i56.QuestionActorCubit(get<_i25.IQuestionCrudRepo>()));
  gh.factory<_i57.QuestionEditorCubit>(
      () => _i57.QuestionEditorCubit(get<_i25.IQuestionCrudRepo>()));
  gh.factory<_i58.AnswerOptionActorCubit>(
      () => _i58.AnswerOptionActorCubit(get<_i25.IAnswerOptionCrudRepo>()));
  gh.factory<_i59.AnswerOptionEditorCubit>(
      () => _i59.AnswerOptionEditorCubit(get<_i25.IAnswerOptionCrudRepo>()));
  gh.factory<_i60.ChatActorBloc>(() => _i60.ChatActorBloc(
      answerItemCrudRepo: get<_i25.IAnswerItemCrudRepo>(),
      answerOptionCrudRepo: get<_i25.IAnswerOptionCrudRepo>()));
  gh.factory<_i61.ChatBotWatcherCubit>(() => _i61.ChatBotWatcherCubit(
      get<_i14.IChatBotWatcherApi>(), get<_i37.IAuthRepo>()));
  gh.factory<_i62.ChatWatcherBloc>(() => _i62.ChatWatcherBloc(
      chatBotRepo: get<_i14.IChatBotWatcherApi>(),
      questionRepo: get<_i14.IQuestionWatcherApi>(),
      qarCrudRepo: get<_i25.IQarCrudRepo>(),
      qarRepoWatcher: get<_i14.IQarWatcherApi>(),
      answerItemRepo: get<_i14.IAnswerItemWatcherApi>(),
      answerOptionRepo: get<_i14.IAnswerOptionWatcherApi>(),
      authFacade: get<_i16.IAuthFacade>()));
  gh.factory<_i63.ChatsOverviewWatcherBloc>(() => _i63.ChatsOverviewWatcherBloc(
      chatBotWatcher: get<_i14.IChatBotWatcherApi>(),
      qarRepoWatcher: get<_i14.IQarWatcherApi>(),
      questionRepoCrud: get<_i25.IQuestionCrudRepo>(),
      answerItemRepoCrud: get<_i25.IAnswerItemCrudRepo>(),
      answerOptionRepoCrud: get<_i25.IAnswerOptionCrudRepo>(),
      authRepo: get<_i37.IAuthRepo>(),
      settingsBloc: get<_i42.SettingsBloc>()));
  return get;
}

class _$InjectableModule extends _i64.InjectableModule {}

class _$FirebaseInjectableModule extends _i65.FirebaseInjectableModule {}
