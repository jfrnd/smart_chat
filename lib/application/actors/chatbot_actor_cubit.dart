import 'package:injectable/injectable.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@injectable
class ChatBotActorCubit extends EntityActorCubit<ChatBot> {
  final IChatBotCrudRepo crudRepo;

  ChatBotActorCubit(this.crudRepo) : super(crudRepo);
}
