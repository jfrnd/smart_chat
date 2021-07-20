// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:smart_chat/application/editors/chatbot_image_editor/chatbot_image_editor_bloc.dart';
import 'package:smart_chat/domain/core/crud_failures.dart';
import 'package:smart_chat/domain/core/valueobjects/image_url.dart';
import 'package:smart_chat/domain/entities/chatbot/chatbot.dart';
import 'package:smart_chat/domain/repositories/api/i_crud_api.dart';
import 'package:smart_chat/domain/repositories/crud/i_crud_repo.dart';
import '../../fixtures/chatbots/diary/chatbot_diary.dart';

class MockIChatBotCrudRepo extends Mock implements IChatBotCrudRepo {}

class MockIImageCrudApi extends Mock implements IImageCrudApi {}

class MockImagePicker extends Mock implements ImagePicker {}

class MockPickedFile extends Mock implements PickedFile {}

void main() {
  late MockIChatBotCrudRepo chatBotCrudRepo;
  late MockIImageCrudApi imageRepo;
  late MockImagePicker imagePicker;
  late DefaultCacheManager cacheManager;
  late MockPickedFile pickedFile;
  late ChatBotImageEditorBloc bloc;

  setUpAll(() {});

  setUp(() {
    registerFallbackValue<ChatBot>(ChatBot.empty());
    registerFallbackValue<Uint8List>(Uint8List(8));

    chatBotCrudRepo = MockIChatBotCrudRepo();
    imageRepo = MockIImageCrudApi();
    imagePicker = MockImagePicker();
    pickedFile = MockPickedFile();
    cacheManager = DefaultCacheManager();
    bloc = ChatBotImageEditorBloc(
        imagePicker, chatBotCrudRepo, imageRepo, cacheManager);
  });

  tearDownAll(() {
    cacheManager.emptyCache();
    cacheManager.dispose();
  });

  tearDown(
    () {
      bloc.close();
      reset(chatBotCrudRepo);
      reset(imageRepo);
      reset(imagePicker);
    },
  );

  group('showImageStarted()', () {
    blocTest(
      'should emit [showImage] with empty image source',
      build: () => bloc,
      act: (_) => bloc.add(
        ChatBotImageEditorEvent.showImageStarted(ImageUrl.empty()),
      ),
      expect: () => [ChatBotImageEditorState.showImage(ImageUrl.empty())],
    );
    blocTest(
      'should emit [showImage] with dummyImageUrl',
      build: () => bloc,
      act: (_) => bloc.add(
        ChatBotImageEditorEvent.showImageStarted(ImageUrl('dummy')),
      ),
      expect: () => [ChatBotImageEditorState.showImage(ImageUrl('dummy'))],
    );
  });
  group('onImageClicked()', () {
    const dummyPath = 'dummyPath';
    const dummyUrl = 'dummyUrl';
    final dummyFile = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);

    blocTest(
      'should not emit any new states when user does not pick an image',
      build: () {
        when(() => imagePicker.getImage(source: ImageSource.gallery))
            .thenAnswer((_) async => null);
        return bloc;
      },
      act: (_) =>
          bloc.add(ChatBotImageEditorEvent.onImageClicked(ChatBot.empty())),
      expect: () => [],
    );

    blocTest(
      '''should not emit any new state when user clicks on image
        while updating is in progress''',
      build: () => bloc,
      seed: () => const ChatBotImageEditorState.updateImageInProgress(),
      act: (_) =>
          bloc.add(ChatBotImageEditorEvent.onImageClicked(ChatBot.empty())),
      expect: () => [],
    );

    blocTest(
      '''should emit: 
        [updateInProgress],
        [showImage]
        when user picks a new image and update is successful''',
      build: () {
        when(() => imagePicker.getImage(source: ImageSource.gallery))
            .thenAnswer((_) async => pickedFile);
        when(() => imageRepo.updateImage(
              remoteImagePath: chatBotDiary.firebaseImagePath,
              localImagePath: dummyPath,
            )).thenAnswer((_) async => const Right(dummyUrl));
        when(() => chatBotCrudRepo.update(any()))
            .thenAnswer((_) async => Right(ChatBot.empty()));
        when(() => pickedFile.path).thenReturn(dummyPath);

        when(() => pickedFile.readAsBytes()).thenAnswer((_) async => dummyFile);

        return bloc;
      },
      act: (_) =>
          bloc.add(ChatBotImageEditorEvent.onImageClicked(chatBotDiary)),
      expect: () => [
        const ChatBotImageEditorState.updateImageInProgress(),
        ChatBotImageEditorState.showImage(ImageUrl(dummyUrl)),
      ],
    );

    test(
      'file should be in the cache',
      () async {
        final file = await cacheManager.getSingleFile(dummyUrl);
        final fileAsBytes = await file.readAsBytes();

        expect(fileAsBytes, equals(dummyFile));
      },
    );

    blocTest(
      '''should emit:
        [updateInProgress],
        [showImage] with old image
        when user picks a new image but
        but chatBot cannot be updated (chatBotRepo.update() return failure)''',
      build: () {
        when(() => imagePicker.getImage(source: ImageSource.gallery))
            .thenAnswer((_) async => PickedFile(dummyPath));
        when(() => imageRepo.updateImage(
              remoteImagePath: chatBotDiary.firebaseImagePath,
              localImagePath: dummyPath,
            )).thenAnswer((_) async => const Right(dummyUrl));
        when(() => chatBotCrudRepo.update(any()))
            .thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        return bloc;
      },
      act: (_) =>
          bloc.add(ChatBotImageEditorEvent.onImageClicked(chatBotDiary)),
      expect: () => [
        const ChatBotImageEditorState.updateImageInProgress(),
        ChatBotImageEditorState.showImage(chatBotDiary.imageUrl),
      ],
    );

    blocTest(
      '''should emit:
        [updateInProgress],
        [showImage] with old image
        when user picks a new image
        but image cannot be updated (imageRepo.update() return failure)''',
      build: () {
        when(() => imagePicker.getImage(source: ImageSource.gallery))
            .thenAnswer((_) async => PickedFile(dummyPath));
        when(() => imageRepo.updateImage(
              remoteImagePath: chatBotDiary.firebaseImagePath,
              localImagePath: dummyPath,
            )).thenAnswer((_) async => const Left(CrudFailure.unexpected()));
        when(() => chatBotCrudRepo.update(any()))
            .thenAnswer((_) async => Right(ChatBot.empty()));
        return bloc;
      },
      act: (_) =>
          bloc.add(ChatBotImageEditorEvent.onImageClicked(chatBotDiary)),
      expect: () => [
        const ChatBotImageEditorState.updateImageInProgress(),
        ChatBotImageEditorState.showImage(chatBotDiary.imageUrl),
      ],
    );
  });
}
