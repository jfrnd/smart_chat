import 'package:injectable/injectable.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@injectable
class QuestionActorCubit extends EntityActorCubit<Question> {
  final IQuestionCrudRepo crudRepo;

  QuestionActorCubit(this.crudRepo) : super(crudRepo);
}
