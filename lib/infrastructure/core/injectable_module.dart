// Package imports:
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectableModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
  @lazySingleton
  DefaultCacheManager get cacheManger => DefaultCacheManager();
}
