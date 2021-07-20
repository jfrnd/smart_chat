part of 'qar_selector_bloc.dart';

@freezed
class QarSelectorEvent with _$QarSelectorEvent {
  const factory QarSelectorEvent.qarSelected(UniqueId qarId) = _QarSelected;
  const factory QarSelectorEvent.nextQarSelected() = _NextQarSelected;
  const factory QarSelectorEvent.mostRecentQarSelected() =
      _MostRecentQarSelected;
  const factory QarSelectorEvent.filterChatWatcherStateByQar(Qar qar) =
      _FilterChatWatcherStateByQar;
  const factory QarSelectorEvent.newSessionCreated(UniqueId chatBotId) =
      _NewSessionCreated;
}
