import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/src/annotation_super_generator.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_build/cloud_firestore_serdes.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_sqlite_generators.dart';
import 'package:source_gen/source_gen.dart';
import 'package:brick_offline_first_abstract/annotations.dart';

/// Output serializing code for all models with the @[ConnectOfflineFirstWithRest] annotation
class OfflineFirstGenerator extends AnnotationSuperGenerator<ConnectOfflineFirstWithRest> {
  /// The prefix to the adapter name; useful if extending `OfflineFirstRepository`.
  /// Defaults to `OfflineFirst`.
  final String superAdapterName;

  /// The prefix to the repository name, specified when declaring the repository type in
  /// serializing functions; useful if extending `OfflineFirstRepository`.
  /// Defaults to `OfflineFirst`.
  final String repositoryName;

  const OfflineFirstGenerator({
    this.superAdapterName = 'OfflineFirst',
    this.repositoryName = 'OfflineFirst',
  });

  /// Given an [element] and an [annotation], scaffold generators
  List<SerdesGenerator> buildGenerators(Element element, ConstantReader annotation) {
    final cloudFirestore =
        CloudFirestoreSerdes(element, annotation, repositoryName: repositoryName);
    final sqlite = OfflineFirstSqliteSerdes(element, annotation, repositoryName: repositoryName);
    return <SerdesGenerator>[]..addAll(cloudFirestore.generators)..addAll(sqlite.generators);
  }
}
