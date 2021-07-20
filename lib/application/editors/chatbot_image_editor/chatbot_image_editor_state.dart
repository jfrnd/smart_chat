part of 'chatbot_image_editor_bloc.dart';

@freezed
class ChatBotImageEditorState with _$ChatBotImageEditorState {
  const factory ChatBotImageEditorState.initial() = _Initial;
  const factory ChatBotImageEditorState.showImage(ImageUrl url) = _ShowImage;
  const factory ChatBotImageEditorState.updateImageInProgress() = _UpdateImageInProgress;
}
