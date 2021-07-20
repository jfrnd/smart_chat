// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option.dart';
import 'package:smart_chat/domain/entities/answer_option/answer_option_body.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@injectable
class AnswerOptionEditorCubit
    extends EntityEditorCubit<AnswerOption, AnswerOptionBody> {
  AnswerOptionEditorCubit(IAnswerOptionCrudRepo repo) : super(repo);
}
