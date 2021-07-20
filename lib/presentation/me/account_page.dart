// Flutter imports:
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:smart_chat/application/watchers/user_watcher_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/user/user.dart';

// Project imports:
import 'package:smart_chat/injection.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: BlocProvider(
        create: (context) =>
            getIt<UserWatcherCubit>()..watchSignedInUserStarted(),
        child: BlocBuilder<UserWatcherCubit, EntityWatcherState<User>>(
          builder: (context, state) {
            return state.map(
              initial: (_) => Container(),
              deleted: (_) => const Text('Deleted'),
              loadInProgress: (_) =>
                  const Center(child: CircularProgressIndicator()),
              loadFailure: (state) => Text(state.failure.toString()),
              loadSuccess: (state) {
                final user = state.entityList.first();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CenteredListTile(
                      onTap: () => FlushbarHelper.createInformation(
                              message: "not implemented yet.")
                          .show(context),
                      leading: const Icon(Icons.person),
                      title: const Text('Username'),
                      subtitle: Text(user.userName.getOrCrash()),
                      trailing: const Icon(Icons.edit),
                    ),
                    CenteredListTile(
                      onTap: () => FlushbarHelper.createInformation(
                              message: "not implemented yet.")
                          .show(context),
                      leading: const Icon(Icons.email),
                      title: const Text('E-Mail address'),
                      subtitle: Text(user.email.getOrCrash()),
                      trailing: const Icon(Icons.edit),
                    ),
                    CenteredListTile(
                      onTap: () => FlushbarHelper.createInformation(
                              message: "not implemented yet.")
                          .show(context),
                      leading: const Icon(Icons.language_outlined),
                      title: const Text('UTC Timezone Offset'),
                      subtitle: Text(user.timeZoneOffset.inHours.toString()),
                      trailing: const Icon(Icons.edit),
                    ),
                    CenteredListTile(
                      onTap: () => FlushbarHelper.createInformation(
                              message: "not implemented yet.")
                          .show(context),
                      leading: const Icon(Icons.password),
                      title: const Text('Password'),
                      subtitle: const Text("*******"),
                      trailing: const Icon(Icons.edit),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
