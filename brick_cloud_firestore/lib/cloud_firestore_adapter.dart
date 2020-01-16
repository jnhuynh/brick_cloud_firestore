import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_core/core.dart';

abstract class CloudFirestoreAdapter<_Model extends Model> implements Adapter<_Model> {
  /// Retrieves data under this key when deserializing
  String get fromKey;

  /// Submits data under this key when serializing
  String get toKey;

  Future<_Model> fromCloudFirestore(
    Map<String, dynamic> data, {
    CloudFirestoreProvider provider,
    ModelRepository<CloudFirestoreModel> repository,
  });
  Future<Map<String, dynamic>> toCloudFirestore(
    _Model instance, {
    CloudFirestoreProvider provider,
    ModelRepository<CloudFirestoreModel> repository,
  });
}
