import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/chat/chat_actor/chat_actor_bloc.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

class MockIAnswerItemCrudRepo extends Mock implements IAnswerItemCrudRepo {}

class MockIAnswerOptionCrudRepo extends Mock implements IAnswerOptionCrudRepo {}

void main() {
  late MockIAnswerItemCrudRepo answerItemCrudRepo;
  late MockIAnswerOptionCrudRepo answerOptionCrudRepo;
  late ChatActorBloc bloc;

  setUp(() {
    answerItemCrudRepo = MockIAnswerItemCrudRepo();
    answerOptionCrudRepo = MockIAnswerOptionCrudRepo();
    bloc = ChatActorBloc(
        answerItemCrudRepo: answerItemCrudRepo,
        answerOptionCrudRepo: answerOptionCrudRepo);
  });

  tearDown(() {
    bloc.close();
  });

  group('answerOptionCreatedStarted()', () {
    //TODO answerOptionCreatedStarted()
  });
  group('answerOptionCreatedFinished()', () {
    //TODO answerOptionCreatedFinished()
  });
  group('answerItemDeleted()', () {
    //TODO answerItemDeleted()
  });
  group('answerItemsCreated()', () {
    //TODO answerItemsCreated()
  });
}
