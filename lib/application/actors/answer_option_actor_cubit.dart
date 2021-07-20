import 'package:injectable/injectable.dart';
import 'package:smart_chat/domain/cubits/entity_actor/entity_actor_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@injectable
class AnswerOptionActorCubit extends EntityActorCubit<AnswerOption> {
  final IAnswerOptionCrudRepo crudRepo;

  AnswerOptionActorCubit(this.crudRepo) : super(crudRepo);
}
