// Dart imports:

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

// Project imports:
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot_name.dart';
import 'package:smart_chat/domain/entities/subscription/subscription_trigger.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@injectable
class ChatBotEditorCubit extends EntityEditorCubit<ChatBot, ChatBotName> {
  ChatBotEditorCubit(IChatBotCrudRepo repo) : super(repo);

  void triggersChanged({
    required KtList<SubscriptionTrigger> triggers,
  }) {
    emit(
      state.copyWith(
        entity: state.entity?.copyWith(triggers: triggers),
      ),
    );
  }
}
