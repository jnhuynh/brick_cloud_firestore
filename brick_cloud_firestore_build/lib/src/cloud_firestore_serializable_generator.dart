import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/src/annotation_super_generator.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_field_serializer_generator.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_fields.dart';
import 'package:source_gen/source_gen.dart';

/// Output serializing code for all models with the @[CloudFirestoreSerializable] annotation
class CloudFirestoreSerializableGenerator
    extends AnnotationSuperGenerator<CloudFirestoreSerializable> {
  final String superAdapterName;
  final String repositoryName;

  const CloudFirestoreSerializableGenerator({
    this.superAdapterName = 'CloudFirestore',
    this.repositoryName = 'CloudFirestore',
  });

  /// Given an [element] and an [annotation], scaffold generators
  List<SerdesGenerator> buildGenerators(Element element, ConstantReader annotation) {
    final fields = CloudFirestoreFields(element);

    final deserializer = CloudFirestoreFieldSerializerGenerator(
      element,
      fields,
      repositoryName: repositoryName,
    );
    final serializer = CloudFirestoreFieldSerializerGenerator(
      element,
      fields,
      repositoryName: repositoryName,
    );

    return [
      deserializer,
      serializer,
    ];
  }
}
