import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/src/adapter_generator.dart';
import 'package:brick_build/src/annotation_super_generator.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore/src/cloud_firestore_field_serdes_generator.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Output serializing code for all models with the @[ConnectCloudFirestoreSerializableWithRest] annotation
class CloudFirestoreSerializableGenerator
    extends AnnotationSuperGenerator<CloudFirestoreSerializable> {
  /// The prefix to the adapter name; useful if extending `CloudFirestoreSerializableRepository`.
  /// Defaults to `CloudFirestoreSerializable`.
  final String superAdapterName;

  /// The prefix to the repository name, specified when declaring the repository type in
  /// serializing functions; useful if extending `CloudFirestoreSerializableRepository`.
  /// Defaults to `CloudFirestoreSerializable`.
  final String repositoryName;

  const CloudFirestoreSerializableGenerator({
    this.superAdapterName = 'CloudFirestoreSerializable',
    this.repositoryName = 'CloudFirestoreSerializable',
  });

  /// Given an [element] and an [annotation], scaffold generators
  List<SerdesGenerator> buildGenerators(Element element, ConstantReader annotation) {
    final cloud =
        CloudFirestoreFieldSerdesGenerator(element, annotation, repositoryName: repositoryName);
    final generators = <SerdesGenerator>[];
    generators.addAll(cloud.generators);
    return generators;
  }

  @override
  String generateForAnnotatedElement(element, annotation, buildStep) {
    final generators = buildGenerators(element, annotation);

    return generators.fold<List<String>>(<String>[], (acc, generator) {
      acc.add(generator.generate());
      return acc;
    }).join('\n');
  }

  @override
  String generateAdapter(Element element, ConstantReader annotation, BuildStep buildStep) {
    final generators = buildGenerators(element, annotation);

    final adapterGenerator = AdapterGenerator(
      superAdapterName: superAdapterName,
      className: element.name,
      generators: generators,
    );

    return adapterGenerator.generate();
  }
}