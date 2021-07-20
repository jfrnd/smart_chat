part of 'chatbot_image_editor_bloc.dart';

@freezed
class ChatBotImageEditorEvent with _$ChatBotImageEditorEvent {
  const factory ChatBotImageEditorEvent.showImageStarted(ImageUrl url) = _ShowImageStarted;
  const factory ChatBotImageEditorEvent.onImageClicked(ChatBot chatBot) = _OnImageClicked;
}