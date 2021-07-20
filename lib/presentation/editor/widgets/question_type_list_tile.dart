import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';
import 'package:smart_chat/application/watchers/question_watcher_cubit.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/presentation/core/widgets/my_list_tiles.dart';

class QuestionTypeListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionWatcherCubit, EntityWatcherState<Question>>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => Container(),
          loadSuccess: (state) {
            final question = state.entityList.first();
            return InvertedListTile(
              overline: "Type",
              leading: question.type.asIcon(),
              body: question.type.toDisplayedString(),
            );
          },
        );
      },
    );
  }
}
