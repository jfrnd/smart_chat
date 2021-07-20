// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/m_unit.dart';
import 'package:smart_chat/domain/core/valueobjects/numeric_value.dart';
import 'package:smart_chat/domain/cubits/entity_editor/entity_editor_cubit.dart';
import 'package:smart_chat/domain/entities/question/digits.dart';
import 'package:smart_chat/domain/entities/question/question.dart';
import 'package:smart_chat/domain/entities/question/question_body.dart';
import 'package:smart_chat/domain/entities/question/question_type.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

@injectable
class QuestionEditorCubit extends EntityEditorCubit<Question, QuestionBody> {
  QuestionEditorCubit(IQuestionCrudRepo repo) : super(repo);

  void typeChanged({
    required QuestionType type,
  }) {
    emit(
      state.copyWith(
        entity: state.entity?.copyWith(type: type),
      ),
    );
  }

  void toggleMultiSelection({
    required bool multiSelection,
  }) {
    emit(
      state.copyWith(
        entity: state.entity?.copyWith(multiSelection: multiSelection),
      ),
    );
  }

  void unitChanged({
    required MUnit unit,
  }) {
    if (state.entity?.type is Numeric) {
      emit(
        state.copyWith(
          entity: state.entity?.copyWith(
            unit: unit,
          ),
        ),
      );
    }
  }

  void minValueChanged(double minVal) {
    emit(
      state.copyWith(
        entity: state.entity?.copyWith(
          minVal: NumericValue.fromDouble(minVal),
        ),
      ),
    );
  }

  void maxValueChanged(double maxVal) {
    emit(
      state.copyWith(
        entity: state.entity?.copyWith(
          maxVal: NumericValue.fromDouble(maxVal),
        ),
      ),
    );
  }

  void digitsChanged(int digits) {
    emit(
      state.copyWith(
        entity: state.entity?.copyWith(
          digits: Digits(digits),
        ),
      ),
    );
  }
}
