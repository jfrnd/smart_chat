// Flutter imports:
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chat/application/auth/auth_bloc.dart';

// Project imports:
import 'package:smart_chat/application/settings/settings_bloc.dart';
import 'package:smart_chat/application/sign_in_form/sign_in_form_bloc.dart';
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/routes/router.gr.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (getIt<SharedPreferences>().getString(LOCALE) == null) {
      getIt<SharedPreferences>()
          .setString(LOCALE, Localizations.localeOf(context).toString());
    }

    final String localeAsString =
        getIt<SharedPreferences>().getString(LOCALE) ??
            Localizations.localeOf(context).toString();

    context.read<SettingsBloc>().add(
          SettingsEvent.initialized(localeAsString: localeAsString),
        );

    return BlocProvider(
      create: (context) => getIt<SignInFormBloc>(),
      child: Scaffold(
        appBar: AppBar(
            title: Center(child: Text(AppLocalizations.of(context)!.welcome))),
        body: SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              ).show(context);
            },
            (_) {
              AutoRouter.of(context).replace(const HomeRoute());
              context.read<AuthBloc>().add(const AuthEvent.watchAuthState());
            },
          ),
        );
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: AppLocalizations.of(context)!.email,
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.emailChanged(value)),
                  validator: (_) => context
                      .read<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => 'Invalid Email',
                        (_) => null,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: AppLocalizations.of(context)!.password,
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.passwordChanged(value)),
                  validator: (_) =>
                      context.read<SignInFormBloc>().state.password.value.fold(
                            (f) => 'Short Password',
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .signInWithEmailAndPasswordPressed(),
                              );
                        },
                        child: Text(AppLocalizations.of(context)!.signin),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .registerWithEmailAndPasswordPressed(),
                              );
                        },
                        child: Text(AppLocalizations.of(context)!.register),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightBlue)),
                  child: Text(
                    AppLocalizations.of(context)!.signinwithgoogle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
