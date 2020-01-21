/// An annotation used to specify a class to generate code for.
///
/// Creates a serialize/deserialize function
class CloudFirestoreSerializable {
  /// When `true` (the default), all columns are inserted with `NULL`.
  ///
  /// [Sqlite]'s `#nullable` takes precedence. Defaults to `true`.
  final bool nullable;

  /// Creates a new [SqliteSerializable] instance.
  const CloudFirestoreSerializable({
    this.nullable,
  });

  /// An instance of [SqliteSerializable] with all fields set to their default
  /// values.
  static const defaults = CloudFirestoreSerializable(
    nullable: true,
  );
}

@CloudFirestoreSerializable
class User extends CloudFirestoreModel {
  @CloudFireStoreField
  final name;
}

@FileSerializableWithCloudFireStore {
  cloudFirestoreConfig:
  fileCOnfig:
}