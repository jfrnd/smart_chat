// Package imports:
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chat/application/settings/settings_bloc.dart';

// Project imports:
import 'package:smart_chat/domain/core/auth_failure.dart';
import 'package:smart_chat/domain/core/i_meta_data_provider.dart';
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/core/valueobjects/language_code.dart';
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/entities/user/email_address.dart';
import 'package:smart_chat/domain/entities/user/password.dart';
import 'package:smart_chat/domain/entities/user/user.dart';
import 'package:smart_chat/domain/entities/user/user_name.dart';
import 'package:smart_chat/domain/repositories/api/i_auth_facade.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/auth/i_auth_repo.dart';
import '../../../../injection.dart';

@LazySingleton(as: IAuthRepo)
class ClientAuthRepo implements IAuthRepo {
  final IAuthFacade authFacade;
  final IMetaDataProvider metaDataProvider;
  final IUserCrudApi crudApi;
  final SharedPreferences preferences;

  ClientAuthRepo({
    required this.authFacade,
    required this.metaDataProvider,
    required this.crudApi,
    required this.preferences,
  });

  @override
  Future<UniqueId> getSignedInUserId() async {
    return authFacade.getSignedInUserId();
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) {
    final languageCode = LanguageCode(preferences.getString(LOCALE) ?? EN);

    return authFacade
        .registerWithEmailAndPassword(
            emailAddress: emailAddress, password: password)
        .then(
          (failureOrUserId) => failureOrUserId.fold(
            (f) => left(f),
            (id) async {
              final token = await getIt<FirebaseMessaging>().getToken();

              final user = User(
                id: id,
                createdAt: metaDataProvider.getCurrentTime(),
                updatedAt: metaDataProvider.getCurrentTime(),
                activeAt: metaDataProvider.getCurrentTime(),
                imageUrl: ImageUrl.empty(),
                userName: UserName(emailAddress.toString()),
                email: emailAddress,
                token: token!,
                languageCode: languageCode,
                timeZoneOffset: metaDataProvider.getCurrentTimeZoneOffset(),
              );
              return crudApi.createOnDB(user).then(
                    (failureOrCrud) => failureOrCrud.fold(
                      (f) => left(const AuthFailure.serverError()),
                      (r) => right(unit),
                    ),
                  );
            },
          ),
        );
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final token = await getIt<FirebaseMessaging>().getToken();
    final timeZoneOffset = metaDataProvider.getCurrentTimeZoneOffset();
    final languageCode = LanguageCode(preferences.getString(LOCALE) ?? EN);

    return authFacade
        .signInWithEmailAndPassword(
            emailAddress: emailAddress, password: password)
        .then(
          (failureOrId) => failureOrId.fold(
            (f) => left(f),
            (id) => crudApi.readOne(id).then(
                  (failureOrUser) => failureOrUser.fold(
                    (f) => left(const AuthFailure.serverError()),
                    (user) => crudApi
                        .updateOnDB(
                          user.copyWith(
                            token: token,
                            timeZoneOffset: timeZoneOffset,
                            languageCode: languageCode,
                          ),
                        )
                        .then(
                          (failureOrUnit) => failureOrUnit.fold(
                            (f) => left(const AuthFailure.serverError()),
                            (_) => right(unit),
                          ),
                        ),
                  ),
                ),
          ),
        );
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    final languageCode = LanguageCode(preferences.getString(LOCALE) ?? EN);

    return authFacade.signInWithGoogle().then(
          (failureOrData) => failureOrData.fold(
            (f) => left(f),
            (data) async {
              final userId = data.first;
              final email = data.second;
              final isNewUser = data.third;
              final token = await getIt<FirebaseMessaging>().getToken();
              final timeZoneOffset =
                  metaDataProvider.getCurrentTimeZoneOffset();

              if (isNewUser) {
                final user = User(
                  id: userId,
                  createdAt: metaDataProvider.getCurrentTime(),
                  updatedAt: metaDataProvider.getCurrentTime(),
                  activeAt: metaDataProvider.getCurrentTime(),
                  imageUrl: ImageUrl.empty(),
                  userName: UserName(email.toString()),
                  email: email,
                  token: token!,
                  languageCode: languageCode,
                  timeZoneOffset: timeZoneOffset,
                );
                return crudApi.createOnDB(user).then(
                      (failureOrUnit) => failureOrUnit.fold(
                        (f) => left(const AuthFailure.serverError()),
                        (_) => right(unit),
                      ),
                    );
              } else {
                return crudApi.readOne(userId).then(
                      (failureOrUser) => failureOrUser.fold(
                        (f) => left(const AuthFailure.serverError()),
                        (user) => crudApi
                            .updateOnDB(
                              user.copyWith(
                                token: token,
                                timeZoneOffset: timeZoneOffset,
                                languageCode: languageCode,
                              ),
                            )
                            .then(
                              (failureOrUnit) => failureOrUnit.fold(
                                (f) => left(const AuthFailure.serverError()),
                                (_) => right(unit),
                              ),
                            ),
                      ),
                    );
              }
            },
          ),
        );
  }

  @override
  Future<void> signOut() async {
    await getIt<FirebaseMessaging>().getToken().then(
          (token) => authFacade.getSignedInUserId().then(
                (userId) => crudApi
                    .readOne(userId)
                    .then((failureOrUser) => failureOrUser.fold(
                          (l) => authFacade.signOut(),
                          (user) =>
                              crudApi.updateOnDB(user.removeToken(token!)).then(
                                    (value) => authFacade.signOut(),
                                  ),
                        )),
              ),
        );
  }

  @override
  Stream<bool> watchUserState() {
    return authFacade.watchUserState();
  }
}
