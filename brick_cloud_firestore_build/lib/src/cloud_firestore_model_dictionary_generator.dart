import 'package:brick_build/src/model_dictionary_generator.dart';

class CloudFirestoreModelDictionaryGenerator extends ModelDictionaryGenerator {
  @override
  final requiredImports = """
// ignore: unused_import
import 'dart:convert';
import 'package:brick_cloud_firestore/cloud_firestore.dart';
// ignore: unused_import, unused_shown_name
import 'package:brick_core/core.dart' show Query, QueryAction;""";

  /// All classes annotated with `@ConnectCloudFirestore`
  const CloudFirestoreModelDictionaryGenerator();

  @override
  String generate(Map<String, String> classNamesToFileNames) {
    final adapters = adaptersFromFiles(classNamesToFileNames);
    final dictionary = dictionaryFromFiles(classNamesToFileNames);
    final models = modelsFromFiles(classNamesToFileNames);
    return '''
${ModelDictionaryGenerator.HEADER}
$requiredImports

$models

$adapters

/// Cloud Firestore mappings should only be used when initializing a [CloudFirestoreProvider]
final Map<Type, CloudFirestoreAdapter<CloudFirestoreModel>> cloudFirestoreMappings = {
  $dictionary
};
final cloudFirestoreModelDictionary = CloudFirestoreModelDictionary(cloudFirestoreMappings);
''';
  }
}