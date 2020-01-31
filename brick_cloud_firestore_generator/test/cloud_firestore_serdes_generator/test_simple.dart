import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';

// The builder requires a const constructor
// Defined in an absolute path. Unfortunately, an absoluate
// import is requried, so this can't be defined in the test folder
// This is a simple, light-weight class
@CloudFirestoreSerializable()
class Simple extends CloudFirestoreModel {
  final int someField;

  Simple(this.someField);
}

final output = r'''
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

''';
