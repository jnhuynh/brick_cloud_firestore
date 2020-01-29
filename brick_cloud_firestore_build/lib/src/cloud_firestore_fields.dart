import 'package:analyzer/dart/element/element.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_build/src/annotation_finder.dart';
import 'package:brick_build/src/utils/fields_for_class.dart';

/// Convert `@CloudFirestore` annotations into digestible code
class _CloudFirestoreAnnotationFinder extends AnnotationFinder<CloudFirestore> {
  _CloudFirestoreAnnotationFinder();

  @override
  CloudFirestore from(element) {
    // TODO: Support configurations in the future
    return const CloudFirestore();
  }
}

/// Discover all fields with `@CloudFirestore`
class CloudFirestoreFields extends FieldsForClass<CloudFirestore> {
  @override
  final finder = _CloudFirestoreAnnotationFinder();

  CloudFirestoreFields(ClassElement element) : super(element: element);
}
