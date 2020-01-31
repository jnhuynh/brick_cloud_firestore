import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';

@ConnectOfflineFirstWithCloudFirestore()
class Simple extends CloudFirestoreModel {
  final int someField;

  Simple(this.someField);
}

final output = r'''
// GENERATED CODE DO NOT EDIT
// This file should NOT be version controlled and should not be manually edited.
part of '../brick.g.dart';

Future<Simple> _$SimpleFromCloudFirestore(Map<String, dynamic> data,
    {CloudFirestoreProvider provider,
    OfflineFirstWithCloudFirestoreRepository repository}) async {
  return Simple(
      someField: data['some_field'] == null ? null : data['some_field'] as int)
    ..documentId = data['document_id'];
}

Future<Map<String, dynamic>> _$SimpleToCloudFirestore(Simple instance,
    {CloudFirestoreProvider provider,
    OfflineFirstWithCloudFirestoreRepository repository}) async {
  return {'some_field': instance.someField};
}

Future<Simple> _$SimpleFromSqlite(Map<String, dynamic> data,
    {SqliteProvider provider,
    OfflineFirstWithCloudFirestoreRepository repository}) async {
  return Simple(
      someField: data['some_field'] == null ? null : data['some_field'] as int)
    ..primaryKey = data['_brick_id'] as int
    ..documentId = data['document_id'];
}

Future<Map<String, dynamic>> _$SimpleToSqlite(Simple instance,
    {SqliteProvider provider,
    OfflineFirstWithCloudFirestoreRepository repository}) async {
  return {'some_field': instance.someField}
    ..addAll({'document_id': instance.documentId});
}

/// Construct a [Simple]
class SimpleAdapter extends OfflineFirstWithCloudFirestoreAdapter<Simple> {
  SimpleAdapter();

  final Map<String, Map<String, dynamic>> fieldsToSqliteColumns = {
    'primaryKey': {
      'name': '_brick_id',
      'type': int,
      'iterable': false,
      'association': false,
    },
    'someField': {
      'name': 'some_field',
      'type': int,
      'iterable': false,
      'association': false,
    }
  };
  Future<int> primaryKeyByUniqueColumns(
          Simple instance, DatabaseExecutor executor) async =>
      null;
  final String tableName = 'Simple';

  Future<Simple> fromCloudFirestore(Map<String, dynamic> input,
          {provider, repository}) async =>
      await _$SimpleFromCloudFirestore(input,
          provider: provider, repository: repository);
  Future<Map<String, dynamic>> toCloudFirestore(Simple input,
          {provider, repository}) async =>
      await _$SimpleToCloudFirestore(input,
          provider: provider, repository: repository);
  Future<Simple> fromSqlite(Map<String, dynamic> input,
          {provider, repository}) async =>
      await _$SimpleFromSqlite(input,
          provider: provider, repository: repository);
  Future<Map<String, dynamic>> toSqlite(Simple input,
          {provider, repository}) async =>
      await _$SimpleToSqlite(input, provider: provider, repository: repository);
}
''';
