abstract class EntityDto<T> {
  T toDomain();
  Map<String, dynamic> toFireStore();
}
