import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/src/annotation_super_generator.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_generator/cloud_firestore_model_serdes_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Output serializing code for all models with the @[ConnectCloudFirestore] annotation
class ConnectCloudFirestoreGenerator extends AnnotationSuperGenerator<ConnectCloudFirestore> {
  final superAdapterName = 'CloudFirestore';
  final repositoryName = 'CloudFirestore';

  const ConnectCloudFirestoreGenerator();

  /// Given an [element] and an [annotation], scaffold generators
  List<SerdesGenerator> buildGenerators(Element element, ConstantReader annotation) {
    final cloudFirestore =
        CloudFirestoreModelSerdesGenerator(element, annotation, repositoryName: repositoryName);
    return <SerdesGenerator>[]..addAll(cloudFirestore.generators);
  }
}
