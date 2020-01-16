import 'package:brick_core/field_serializable.dart';

// Per field annotation
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
