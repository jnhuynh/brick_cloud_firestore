/// Class to represent per Class annotation after parsing
///
/// Creates a serialize/deserialize function
///
/// e.g.
///
/// @CloudFirestoreSerializable
/// class User extends CloudFirestoreModel {
///   @CloudFireStoreField
///   final name;
/// }

class CloudFirestoreSerializable {
  final bool nullable;

  const CloudFirestoreSerializable({
    this.nullable,
  });

  static const defaults = CloudFirestoreSerializable(
    nullable: true,
  );
}
