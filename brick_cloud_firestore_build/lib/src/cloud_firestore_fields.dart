import 'package:analyzer/dart/element/element.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_build/src/annotation_finder.dart';
import 'package:brick_build/src/utils/fields_for_class.dart';

/// Convert `@CloudFirestoreField` annotations into digestible code
class _CloudFirestoreFieldAnnotationFinder extends AnnotationFinder<CloudFirestoreField> {
  _CloudFirestoreFieldAnnotationFinder();

  @override
  CloudFirestoreField from(element) {
    // TODO: Support configurations in the future
    return const CloudFirestoreField();
  }
}

/// Discover all fields with `@CloudFirestoreField`
class CloudFirestoreFields extends FieldsForClass<CloudFirestoreField> {
  @override
  final finder = _CloudFirestoreFieldAnnotationFinder();

  CloudFirestoreFields(ClassElement element) : super(element: element);
}
