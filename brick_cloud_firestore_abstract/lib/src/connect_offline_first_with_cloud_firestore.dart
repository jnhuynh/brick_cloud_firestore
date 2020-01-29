import 'package:brick_cloud_firestore_abstract/src/cloud_firestore_serializable.dart';
import 'package:brick_offline_first_abstract/annotations.dart';

/// Annotation to generate [OfflineFirstWithCloudFirestoreAdapater] as part of the
/// [OfflineFirstWithCloudFirestore] domain
class ConnectOfflineFirstWithCloudFirestore {
  final CloudFirestoreSerializable cloudFirestoreConfig;
  final SqliteSerializable sqliteConfig;

  const ConnectOfflineFirstWithCloudFirestore({
    this.cloudFirestoreConfig,
    this.sqliteConfig,
  });
}
