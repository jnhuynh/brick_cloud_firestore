import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_build/cloud_firestore_serdes_generator.dart';
import 'package:test/test.dart';
import 'package:source_gen/source_gen.dart';
import 'package:brick_build/testing.dart';

import 'cloud_firestore_serdes/test_simple.dart' as _$simple;

final _generator = TestGenerator();
final folder = 'cloud_firestore_serdes';
final generateReader = generateLibraryForFolder(folder);

void main() {
  group('CloudFirestoreSerdesGenerator', () {
    test('simple', () async {
      await generateExpectation('simple', _$simple.output);
    });
  });
}

/// Output serializing code for all models with the @[ConnectOfflineFirstWithRest] annotation
class TestGenerator extends AnnotationSuperGenerator<CloudFirestoreSerializable> {
  final superAdapterName = 'OfflineFirstWithCloudFirestore';
  final repositoryName = 'OfflineFirstWithCloudFirestore';

  TestGenerator();

  /// Given an [element] and an [annotation], scaffold generators
  List<SerdesGenerator> buildGenerators(Element element, ConstantReader annotation) {
    final cloudFirestore =
        CloudFirestoreSerdesGenerator(element, annotation, repositoryName: repositoryName);
    return cloudFirestore.generators;
  }
}

Future<void> generateExpectation(String filename, String output, {TestGenerator generator}) async {
  final reader = await generateReader(filename);
  final generated = await (generator ?? _generator).generate(reader, null);
  expect(generated.trim(), output.trim());
}
