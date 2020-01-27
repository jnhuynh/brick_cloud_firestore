import 'package:analyzer/dart/element/element.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_field_serdes_generator.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_fields.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_type_checker.dart';

class CloudFirestoreFieldSerializerGenerator
    extends CloudFirestoreFieldSerdesGenerator<CloudFirestoreModel> {
  final CloudFirestoreFields cloudFirestoreFields;

  CloudFirestoreFieldSerializerGenerator(
    ClassElement element,
    CloudFirestoreFields fields, {
    String repositoryName,
  })  : this.cloudFirestoreFields = CloudFirestoreFields(element),
        super(element, fields, repositoryName: repositoryName);

  @override
  CloudFirestoreTypeChecker checkerForType(type) => CloudFirestoreTypeChecker(type);

  @override
  final doesDeserialize = false;

  @override
  String get adapterMethod => '''await $serializingFunctionName(
    input, provider: provider, repository: repository
  )''';

  @override
  String coderForField(field, checker, {wrappedInFuture, fieldAnnotation}) {
    return null;
    // return super.coderForField(field, checker,
    //     wrappedInFuture: wrappedInFuture, fieldAnnotation: fieldAnnotation);
  }
}
