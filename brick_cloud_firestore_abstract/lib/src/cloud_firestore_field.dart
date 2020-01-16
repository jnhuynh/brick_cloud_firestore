import 'package:brick_core/field_serializable.dart';

/// Annotation for field-level config
class CloudFirestore implements FieldSerializable {
  final String defaultValue;

  final String fromGenerator;

  final bool ignore;

  final String name;

  final bool nullable;

  final String toGenerator;

  const CloudFirestore({
    this.defaultValue,
    this.fromGenerator,
    this.ignore,
    this.name,
    this.nullable,
    this.toGenerator,
  });

  static const defaults = CloudFirestore(
    ignore: false,
    nullable: true,
  );
}
