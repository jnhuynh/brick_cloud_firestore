import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/src/utils/fields_for_class.dart';
import 'package:brick_cloud_firestore/src/cloud_firestore_serializable_annotation_finder.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';

/// Discover all fields with `@CloudFirestoreField`
class CloudFirestoreFields extends FieldsForClass<CloudFirestoreSerializable> {
  @override
  final finder = CloudFirestoreSerializableAnnotationFinder();

  CloudFirestoreFields(ClassElement element) : super(element: element);
}
