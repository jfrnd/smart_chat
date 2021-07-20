// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';

part 'chatbot_image_editor_event.dart';
part 'chatbot_image_editor_state.dart';
part 'chatbot_image_editor_bloc.freezed.dart';

@injectable
class ChatBotImageEditorBloc
    extends Bloc<ChatBotImageEditorEvent, ChatBotImageEditorState> {
  final ImagePicker imagePicker;
  final IChatBotCrudRepo chatBotCrudRepo;
  final IImageCrudApi imageRepo;
  final DefaultCacheManager cacheManager;

  ChatBotImageEditorBloc(
      this.imagePicker, this.chatBotCrudRepo, this.imageRepo, this.cacheManager)
      : super(const _Initial());

  @override
  Stream<ChatBotImageEditorState> mapEventToState(
    ChatBotImageEditorEvent event,
  ) async* {
    yield* event.map(
      showImageStarted: (e) async* {
        yield ChatBotImageEditorState.showImage(e.url);
      },
      onImageClicked: (e) async* {
        if (state is! _UpdateImageInProgress) {
          final pickedFile =
              await imagePicker.getImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            yield const ChatBotImageEditorState.updateImageInProgress();

            final failureOrImageUrl = await imageRepo.updateImage(
              remoteImagePath: e.chatBot.firebaseImagePath,
              localImagePath: pickedFile.path,
            );

            final Either<CrudFailure, String> failureOrUrl =
                await failureOrImageUrl.fold(
              (failure) => const Left(CrudFailure.imageFailure()),
              (url) async {
                final failureOrSuccess = await chatBotCrudRepo.update(
                  e.chatBot.copyWith(imageUrl: ImageUrl(url)),
                );

                return failureOrSuccess.fold(
                  (f) => Left(f),
                  (r) async {
                    final source = await pickedFile.readAsBytes();
                    await cacheManager.putFile(url, source);
                    return Right(url);
                  },
                );
              },
            );

            yield failureOrUrl.fold(
              (_) => ChatBotImageEditorState.showImage(e.chatBot.imageUrl),
              (url) => ChatBotImageEditorState.showImage(ImageUrl(url)),
            );
          }
        }
      },
    );
  }
}
