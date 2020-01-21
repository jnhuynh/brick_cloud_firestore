import 'package:brick_build/src/annotation_finder.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';

/// Convert `@CloudFirestoreSerializable` annotations into digestible code
class CloudFirestoreSerializableAnnotationFinder
    extends AnnotationFinder<CloudFirestoreSerializable> {
  CloudFirestoreSerializableAnnotationFinder();

  @override
  CloudFirestoreSerializable from(element) {
    return const CloudFirestoreSerializable();
  }
}
