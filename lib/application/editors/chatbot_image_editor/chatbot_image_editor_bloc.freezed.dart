// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chatbot_image_editor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatBotImageEditorEventTearOff {
  const _$ChatBotImageEditorEventTearOff();

  _ShowImageStarted showImageStarted(ImageUrl url) {
    return _ShowImageStarted(
      url,
    );
  }

  _OnImageClicked onImageClicked(ChatBot chatBot) {
    return _OnImageClicked(
      chatBot,
    );
  }
}

/// @nodoc
const $ChatBotImageEditorEvent = _$ChatBotImageEditorEventTearOff();

/// @nodoc
mixin _$ChatBotImageEditorEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ImageUrl url) showImageStarted,
    required TResult Function(ChatBot chatBot) onImageClicked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ImageUrl url)? showImageStarted,
    TResult Function(ChatBot chatBot)? onImageClicked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowImageStarted value) showImageStarted,
    required TResult Function(_OnImageClicked value) onImageClicked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowImageStarted value)? showImageStarted,
    TResult Function(_OnImageClicked value)? onImageClicked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatBotImageEditorEventCopyWith<$Res> {
  factory $ChatBotImageEditorEventCopyWith(ChatBotImageEditorEvent value,
          $Res Function(ChatBotImageEditorEvent) then) =
      _$ChatBotImageEditorEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatBotImageEditorEventCopyWithImpl<$Res>
    implements $ChatBotImageEditorEventCopyWith<$Res> {
  _$ChatBotImageEditorEventCopyWithImpl(this._value, this._then);

  final ChatBotImageEditorEvent _value;
  // ignore: unused_field
  final $Res Function(ChatBotImageEditorEvent) _then;
}

/// @nodoc
abstract class _$ShowImageStartedCopyWith<$Res> {
  factory _$ShowImageStartedCopyWith(
          _ShowImageStarted value, $Res Function(_ShowImageStarted) then) =
      __$ShowImageStartedCopyWithImpl<$Res>;
  $Res call({ImageUrl url});
}

/// @nodoc
class __$ShowImageStartedCopyWithImpl<$Res>
    extends _$ChatBotImageEditorEventCopyWithImpl<$Res>
    implements _$ShowImageStartedCopyWith<$Res> {
  __$ShowImageStartedCopyWithImpl(
      _ShowImageStarted _value, $Res Function(_ShowImageStarted) _then)
      : super(_value, (v) => _then(v as _ShowImageStarted));

  @override
  _ShowImageStarted get _value => super._value as _ShowImageStarted;

  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_ShowImageStarted(
      url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as ImageUrl,
    ));
  }
}

/// @nodoc

class _$_ShowImageStarted implements _ShowImageStarted {
  const _$_ShowImageStarted(this.url);

  @override
  final ImageUrl url;

  @override
  String toString() {
    return 'ChatBotImageEditorEvent.showImageStarted(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ShowImageStarted &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(url);

  @JsonKey(ignore: true)
  @override
  _$ShowImageStartedCopyWith<_ShowImageStarted> get copyWith =>
      __$ShowImageStartedCopyWithImpl<_ShowImageStarted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ImageUrl url) showImageStarted,
    required TResult Function(ChatBot chatBot) onImageClicked,
  }) {
    return showImageStarted(url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ImageUrl url)? showImageStarted,
    TResult Function(ChatBot chatBot)? onImageClicked,
    required TResult orElse(),
  }) {
    if (showImageStarted != null) {
      return showImageStarted(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowImageStarted value) showImageStarted,
    required TResult Function(_OnImageClicked value) onImageClicked,
  }) {
    return showImageStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowImageStarted value)? showImageStarted,
    TResult Function(_OnImageClicked value)? onImageClicked,
    required TResult orElse(),
  }) {
    if (showImageStarted != null) {
      return showImageStarted(this);
    }
    return orElse();
  }
}

abstract class _ShowImageStarted implements ChatBotImageEditorEvent {
  const factory _ShowImageStarted(ImageUrl url) = _$_ShowImageStarted;

  ImageUrl get url => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ShowImageStartedCopyWith<_ShowImageStarted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OnImageClickedCopyWith<$Res> {
  factory _$OnImageClickedCopyWith(
          _OnImageClicked value, $Res Function(_OnImageClicked) then) =
      __$OnImageClickedCopyWithImpl<$Res>;
  $Res call({ChatBot chatBot});
}

/// @nodoc
class __$OnImageClickedCopyWithImpl<$Res>
    extends _$ChatBotImageEditorEventCopyWithImpl<$Res>
    implements _$OnImageClickedCopyWith<$Res> {
  __$OnImageClickedCopyWithImpl(
      _OnImageClicked _value, $Res Function(_OnImageClicked) _then)
      : super(_value, (v) => _then(v as _OnImageClicked));

  @override
  _OnImageClicked get _value => super._value as _OnImageClicked;

  @override
  $Res call({
    Object? chatBot = freezed,
  }) {
    return _then(_OnImageClicked(
      chatBot == freezed
          ? _value.chatBot
          : chatBot // ignore: cast_nullable_to_non_nullable
              as ChatBot,
    ));
  }
}

/// @nodoc

class _$_OnImageClicked implements _OnImageClicked {
  const _$_OnImageClicked(this.chatBot);

  @override
  final ChatBot chatBot;

  @override
  String toString() {
    return 'ChatBotImageEditorEvent.onImageClicked(chatBot: $chatBot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OnImageClicked &&
            (identical(other.chatBot, chatBot) ||
                const DeepCollectionEquality().equals(other.chatBot, chatBot)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chatBot);

  @JsonKey(ignore: true)
  @override
  _$OnImageClickedCopyWith<_OnImageClicked> get copyWith =>
      __$OnImageClickedCopyWithImpl<_OnImageClicked>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ImageUrl url) showImageStarted,
    required TResult Function(ChatBot chatBot) onImageClicked,
  }) {
    return onImageClicked(chatBot);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ImageUrl url)? showImageStarted,
    TResult Function(ChatBot chatBot)? onImageClicked,
    required TResult orElse(),
  }) {
    if (onImageClicked != null) {
      return onImageClicked(chatBot);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowImageStarted value) showImageStarted,
    required TResult Function(_OnImageClicked value) onImageClicked,
  }) {
    return onImageClicked(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowImageStarted value)? showImageStarted,
    TResult Function(_OnImageClicked value)? onImageClicked,
    required TResult orElse(),
  }) {
    if (onImageClicked != null) {
      return onImageClicked(this);
    }
    return orElse();
  }
}

abstract class _OnImageClicked implements ChatBotImageEditorEvent {
  const factory _OnImageClicked(ChatBot chatBot) = _$_OnImageClicked;

  ChatBot get chatBot => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$OnImageClickedCopyWith<_OnImageClicked> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ChatBotImageEditorStateTearOff {
  const _$ChatBotImageEditorStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _ShowImage showImage(ImageUrl url) {
    return _ShowImage(
      url,
    );
  }

  _UpdateImageInProgress updateImageInProgress() {
    return const _UpdateImageInProgress();
  }
}

/// @nodoc
const $ChatBotImageEditorState = _$ChatBotImageEditorStateTearOff();

/// @nodoc
mixin _$ChatBotImageEditorState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageUrl url) showImage,
    required TResult Function() updateImageInProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageUrl url)? showImage,
    TResult Function()? updateImageInProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ShowImage value) showImage,
    required TResult Function(_UpdateImageInProgress value)
        updateImageInProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ShowImage value)? showImage,
    TResult Function(_UpdateImageInProgress value)? updateImageInProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatBotImageEditorStateCopyWith<$Res> {
  factory $ChatBotImageEditorStateCopyWith(ChatBotImageEditorState value,
          $Res Function(ChatBotImageEditorState) then) =
      _$ChatBotImageEditorStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatBotImageEditorStateCopyWithImpl<$Res>
    implements $ChatBotImageEditorStateCopyWith<$Res> {
  _$ChatBotImageEditorStateCopyWithImpl(this._value, this._then);

  final ChatBotImageEditorState _value;
  // ignore: unused_field
  final $Res Function(ChatBotImageEditorState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ChatBotImageEditorStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'ChatBotImageEditorState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageUrl url) showImage,
    required TResult Function() updateImageInProgress,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageUrl url)? showImage,
    TResult Function()? updateImageInProgress,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ShowImage value) showImage,
    required TResult Function(_UpdateImageInProgress value)
        updateImageInProgress,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ShowImage value)? showImage,
    TResult Function(_UpdateImageInProgress value)? updateImageInProgress,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ChatBotImageEditorState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$ShowImageCopyWith<$Res> {
  factory _$ShowImageCopyWith(
          _ShowImage value, $Res Function(_ShowImage) then) =
      __$ShowImageCopyWithImpl<$Res>;
  $Res call({ImageUrl url});
}

/// @nodoc
class __$ShowImageCopyWithImpl<$Res>
    extends _$ChatBotImageEditorStateCopyWithImpl<$Res>
    implements _$ShowImageCopyWith<$Res> {
  __$ShowImageCopyWithImpl(_ShowImage _value, $Res Function(_ShowImage) _then)
      : super(_value, (v) => _then(v as _ShowImage));

  @override
  _ShowImage get _value => super._value as _ShowImage;

  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_ShowImage(
      url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as ImageUrl,
    ));
  }
}

/// @nodoc

class _$_ShowImage implements _ShowImage {
  const _$_ShowImage(this.url);

  @override
  final ImageUrl url;

  @override
  String toString() {
    return 'ChatBotImageEditorState.showImage(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ShowImage &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(url);

  @JsonKey(ignore: true)
  @override
  _$ShowImageCopyWith<_ShowImage> get copyWith =>
      __$ShowImageCopyWithImpl<_ShowImage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageUrl url) showImage,
    required TResult Function() updateImageInProgress,
  }) {
    return showImage(url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageUrl url)? showImage,
    TResult Function()? updateImageInProgress,
    required TResult orElse(),
  }) {
    if (showImage != null) {
      return showImage(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ShowImage value) showImage,
    required TResult Function(_UpdateImageInProgress value)
        updateImageInProgress,
  }) {
    return showImage(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ShowImage value)? showImage,
    TResult Function(_UpdateImageInProgress value)? updateImageInProgress,
    required TResult orElse(),
  }) {
    if (showImage != null) {
      return showImage(this);
    }
    return orElse();
  }
}

abstract class _ShowImage implements ChatBotImageEditorState {
  const factory _ShowImage(ImageUrl url) = _$_ShowImage;

  ImageUrl get url => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ShowImageCopyWith<_ShowImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UpdateImageInProgressCopyWith<$Res> {
  factory _$UpdateImageInProgressCopyWith(_UpdateImageInProgress value,
          $Res Function(_UpdateImageInProgress) then) =
      __$UpdateImageInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$UpdateImageInProgressCopyWithImpl<$Res>
    extends _$ChatBotImageEditorStateCopyWithImpl<$Res>
    implements _$UpdateImageInProgressCopyWith<$Res> {
  __$UpdateImageInProgressCopyWithImpl(_UpdateImageInProgress _value,
      $Res Function(_UpdateImageInProgress) _then)
      : super(_value, (v) => _then(v as _UpdateImageInProgress));

  @override
  _UpdateImageInProgress get _value => super._value as _UpdateImageInProgress;
}

/// @nodoc

class _$_UpdateImageInProgress implements _UpdateImageInProgress {
  const _$_UpdateImageInProgress();

  @override
  String toString() {
    return 'ChatBotImageEditorState.updateImageInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _UpdateImageInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageUrl url) showImage,
    required TResult Function() updateImageInProgress,
  }) {
    return updateImageInProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageUrl url)? showImage,
    TResult Function()? updateImageInProgress,
    required TResult orElse(),
  }) {
    if (updateImageInProgress != null) {
      return updateImageInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_ShowImage value) showImage,
    required TResult Function(_UpdateImageInProgress value)
        updateImageInProgress,
  }) {
    return updateImageInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_ShowImage value)? showImage,
    TResult Function(_UpdateImageInProgress value)? updateImageInProgress,
    required TResult orElse(),
  }) {
    if (updateImageInProgress != null) {
      return updateImageInProgress(this);
    }
    return orElse();
  }
}

abstract class _UpdateImageInProgress implements ChatBotImageEditorState {
  const factory _UpdateImageInProgress() = _$_UpdateImageInProgress;
}
