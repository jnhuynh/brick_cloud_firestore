import 'package:brick_core/field_serializable.dart';

// Class to represent per field annotation after parsing
///
/// e.g.
///
/// @CloudFirestoreSerializable
/// class User extends CloudFirestoreModel {
///   @CloudFireStoreField
///   final name;
/// }

class CloudFirestoreField implements FieldSerializable {
  final dynamic defaultValue;
  final String fromGenerator;
  final bool ignore;
  final String name;
  final bool nullable;
  final String toGenerator;
  final bool unique;

  const CloudFirestoreField({
    this.defaultValue,
    this.fromGenerator,
    this.ignore,
    this.name,
    this.nullable,
    this.toGenerator,
    this.unique,
  });

  static const defaults = CloudFirestoreField(
    ignore: false,
    unique: false,
  );
}
