// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/entity.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

import 'package:smart_chat/utils/date_time_extensions.dart';

class CreatedAtListTile<T extends TranslatableEntity,
    W extends EntityWatcherCubit<T>> extends StatelessWidget {
  const CreatedAtListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<W, EntityWatcherState<T>>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          loadSuccess: (state) => InvertedListTile(
            leading: const Icon(
              Icons.timer,
            ),
            overline: "created at",
            body: state.entityList.first().createdAt.toDisplayedString(),
          ),
        );
      },
    );
  }
}

class UpdatedAtListTile<T extends TranslatableEntity,
    W extends EntityWatcherCubit<T>> extends StatelessWidget {
  const UpdatedAtListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<W, EntityWatcherState<T>>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          loadSuccess: (state) => InvertedListTile(
            leading: const Icon(
              Icons.timer,
            ),
            overline: "last update at",
            body: state.entityList.first().updatedAt.toDisplayedString(),
          ),
        );
      },
    );
  }
}
