// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';
import 'package:smart_chat/domain/cubits/entity_watcher/entity_watcher_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/api/i_watcher_api.dart';

@injectable
class QuestionWatcherCubit extends EntityWatcherCubit<Question> {
  final IQuestionWatcherApi questionRepoWatcher;

  QuestionWatcherCubit(this.questionRepoWatcher) : super(questionRepoWatcher);

  Future<void> watchAllOfChatBotStarted(UniqueId chatBotId) async {
    super.watchAllOfParentStarted(chatBotId);
  }
}
