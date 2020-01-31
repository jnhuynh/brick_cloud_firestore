import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/src/annotation_super_generator.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_build/cloud_firestore_serdes_generator.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_sqlite_generators.dart';
import 'package:source_gen/source_gen.dart';
import 'package:brick_offline_first_abstract/annotations.dart';

/// Output serializing code for all models with the @[ConnectOfflineFirstWithRest] annotation
class OfflineFirstGenerator extends AnnotationSuperGenerator<ConnectOfflineFirstWithRest> {
  final superAdapterName = 'OfflineFirstWithCloudFirestore';
  final repositoryName = 'OfflineFirstWithCloudFirestore';

  const OfflineFirstGenerator();

  /// Given an [element] and an [annotation], scaffold generators
  List<SerdesGenerator> buildGenerators(Element element, ConstantReader annotation) {
    final cloudFirestore =
        CloudFirestoreSerdesGenerator(element, annotation, repositoryName: repositoryName);
    final sqlite = OfflineFirstSqliteSerdes(element, annotation, repositoryName: repositoryName);
    return <SerdesGenerator>[]..addAll(cloudFirestore.generators)..addAll(sqlite.generators);
  }
}
