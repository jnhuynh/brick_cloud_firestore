import 'package:brick_core/field_serializable.dart';

// Class to represent per field annotation after parsing
///
/// e.g.
///
/// @CloudFirestoreSerializable
/// class User extends CloudFirestoreModel {
///   @CloudFirestore
///   final name;
/// }

class CloudFirestore implements FieldSerializable {
  final String defaultValue;
  final String fromGenerator;
  final bool ignore;
  final String name;
  final bool nullable;
  final String toGenerator;
  final bool unique;

  const CloudFirestore({
    this.defaultValue,
    this.fromGenerator,
    this.ignore,
    this.name,
    this.nullable,
    this.toGenerator,
    this.unique,
  });

  static const defaults = CloudFirestore(
    ignore: false,
    unique: false,
  );
}
