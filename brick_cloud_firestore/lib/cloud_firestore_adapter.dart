import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_core/core.dart';

abstract class CloudFirestoreAdapter<_Model extends Model> implements Adapter<_Model> {
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
