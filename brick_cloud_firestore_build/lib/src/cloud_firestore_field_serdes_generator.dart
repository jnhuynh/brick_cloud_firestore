import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_fields.dart';
import 'package:meta/meta.dart';

/// Base class for CloudFirestore serialize and deserialize generator.
abstract class CloudFirestoreFieldSerdesGenerator<_Model extends CloudFirestoreModel>
    extends SerdesGenerator<CloudFirestoreField> {
  final String providerName = 'CloudFirestore';
  final String repositoryName;

  CloudFirestoreFieldSerdesGenerator(
    ClassElement element,
    CloudFirestoreFields fields, {
    @required this.repositoryName,
  }) : super(element, fields);
}
