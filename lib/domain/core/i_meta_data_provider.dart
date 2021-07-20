// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:smart_chat/domain/core/valueobjects/unique_id.dart';

abstract class IMetaDataProvider {
  DateTime getCurrentTime();
  UniqueId getUniqueId();
  UniqueId getSessionId();
  Duration getCurrentTimeZoneOffset();
}

@LazySingleton(as: IMetaDataProvider)
class MetaDataProvider extends IMetaDataProvider {
  @override
  DateTime getCurrentTime() {
    return DateTime.now();
  }

  @override
  UniqueId getUniqueId() {
    return UniqueId();
  }

  @override
  UniqueId getSessionId() {
    return UniqueId();
    // final id = DateTime.now().toIso8601String();
    // return UniqueId.fromUniqueString(id);
  }

  @override
  Duration getCurrentTimeZoneOffset() => DateTime.now().timeZoneOffset;
}
