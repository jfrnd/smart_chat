abstract class ValueFailure<T> {
  const ValueFailure();

  T get failureInfo;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueFailure<T> && o.failureInfo == failureInfo;
  }

  @override
  int get hashCode => failureInfo.hashCode;
}
