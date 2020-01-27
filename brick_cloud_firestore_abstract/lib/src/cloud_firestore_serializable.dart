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
  const CloudFirestoreSerializable();

  static const defaults = CloudFirestoreSerializable();
}
