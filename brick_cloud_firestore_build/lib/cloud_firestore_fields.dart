import 'package:analyzer/dart/element/element.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_build/generators.dart';

/// Convert `@CloudFirestore` annotations into digestible code
class _CloudFirestoreAnnotationFinder extends AnnotationFinder<CloudFirestore> {
  _CloudFirestoreAnnotationFinder();

  @override
  CloudFirestore from(element) {
    final obj = objectForField(element);

    if (obj == null) {
      return CloudFirestore(
        ignore: CloudFirestore.defaults.ignore,
        nullable: CloudFirestore.defaults.nullable,
      );
    }

    return CloudFirestore(
      defaultValue: obj.getField('defaultValue').toStringValue(),
      ignore: obj.getField('ignore').toBoolValue() ?? CloudFirestore.defaults.ignore,
      name: obj.getField('name').toStringValue() ?? StringHelpers.snakeCase(element.name),
      nullable: obj.getField('nullable').toBoolValue() ?? CloudFirestore.defaults.nullable,
      fromGenerator: obj.getField('fromGenerator').toStringValue(),
      toGenerator: obj.getField('toGenerator').toStringValue(),
    );
  }
}

/// Discover all fields with `@CloudFirestore`
class CloudFirestoreFields extends FieldsForClass<CloudFirestore> {
  @override
  final finder = _CloudFirestoreAnnotationFinder();

  CloudFirestoreFields(ClassElement element) : super(element: element);
}
