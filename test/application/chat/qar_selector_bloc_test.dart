import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_chat/application/chat/chat_watcher/chat_watcher_bloc.dart';
import 'package:smart_chat/application/chat/qar_selector/qar_selector_bloc.dart';

class MockChatWatcherBloc extends Mock implements ChatWatcherBloc {}

void main() {
  late MockChatWatcherBloc chatWatcherBloc;
  late QarSelectorBloc bloc;

  setUp(() {
    chatWatcherBloc = MockChatWatcherBloc();
    bloc = QarSelectorBloc(chatWatcherBloc: chatWatcherBloc);
  });

  tearDown(() {
    bloc.close();
  });

  group('filterChatWatcherStateByQar()', () {
    //TODO filterChatWatcherStateByQar()
  });
  group('mostRecentQarSelected()', () {
    //TODO mostRecentQarSelected()
  });
  group('nextQarSelected()', () {
    //TODO nextQarSelected()
  });
  group('qarSelected()', () {
    //TODO qarSelected()
  });
  group('newSessionCreated()', () {
    //TODO newSessionCreated()
  });
}
