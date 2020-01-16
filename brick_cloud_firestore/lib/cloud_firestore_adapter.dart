import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_core/core.dart';
import 'package:brick_offline_first/offline_first.dart';

abstract class CloudFirestoreAdapter<_Model extends CloudFirestoreModel>
    implements Adapter<_Model> {
  /// All models should be nested under a top-level key.
  /// The collectionNode name is analogous to a SQLite table as it
  /// contains the documents within this collection.
  String get collectionNodeKey;

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

abstract class OfflineFirstWithCloudFirestoreAdapter<
        _Model extends OfflineFirstWithCloudFirestoreModel> extends OfflineFirstAdapter<_Model>
    with CloudFirestoreAdapter<_Model> {
  OfflineFirstWithCloudFirestoreAdapter();
}
