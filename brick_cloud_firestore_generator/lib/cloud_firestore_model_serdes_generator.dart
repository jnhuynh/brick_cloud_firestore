import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'package:brick_cloud_firestore_generator/cloud_firestore_fields.dart';
import 'package:brick_cloud_firestore_generator/cloud_firestore_field_deserializer_generator.dart';
import 'package:brick_cloud_firestore_generator/cloud_firestore_field_serializer_generator.dart';

class CloudFirestoreModelSerdesGenerator
    extends ProviderSerializableGenerator<CloudFirestoreSerializable> {
  /// Repository prefix passed to the generators. `Repository` will be appended and
  /// should not be included.
  final String repositoryName;

  CloudFirestoreModelSerdesGenerator(
    Element element,
    ConstantReader reader, {
    this.repositoryName,
  }) : super(element, reader, configKey: 'cloudFirestoreConfig');

  @override
  CloudFirestoreSerializable get config => null;

  @override
  get generators {
    final classElement = element as ClassElement;
    final fields = CloudFirestoreFields(classElement);

    final deserializer =
        CloudFirestoreDeserializerGenerator(classElement, fields, repositoryName: repositoryName);
    final serializer =
        CloudFirestoreSerializerGenerator(classElement, fields, repositoryName: repositoryName);
    return [deserializer, serializer];
  }
}
