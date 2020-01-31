import 'package:brick_build/src/model_dictionary_generator.dart';

class OfflineFirstModelDictionaryGenerator extends ModelDictionaryGenerator {
  @override
  final requiredImports = """
// ignore: unused_import
import 'dart:convert';
import 'package:brick_sqlite/sqlite.dart' show SqliteModel, SqliteAdapter, SqliteModelDictionary;
import 'package:brick_cloud_firestore/cloud_firestore.dart' show CloudFirestoreModel, CloudFirestoreAdapter, CloudFirestoreModelDictionary;
// ignore: unused_import, unused_shown_name
import 'package:brick_core/core.dart' show Query, QueryAction;
// ignore: unused_import, unused_shown_name
import 'package:sqflite/sqflite.dart' show DatabaseExecutor;""";

  /// All classes annotated with `@ConnectOfflineFirstWithRest`
  const OfflineFirstModelDictionaryGenerator();

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

/// Cloud Firestore mappings should only be used when initializing a [CloudFirestore]
final Map<Type, CloudFirestoreAdapter<CloudFirestoreModel>> cloudFirestoreMappings = {
  $dictionary
};
final cloudFirestoreModelDictionary = CloudFirestoreDictionary(cloudFirestoreMappings);

/// Sqlite mappings should only be used when initializing a [SqliteProvider]
final Map<Type, SqliteAdapter<SqliteModel>> sqliteMappings = {
  $dictionary
};
final sqliteModelDictionary = SqliteModelDictionary(sqliteMappings);
''';
  }
}
