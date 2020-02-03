import 'package:brick_cloud_firestore_abstract/src/cloud_firestore_serializable.dart';

/// Class level annotation for just CloudFirestore.
class ConnectCloudFirestore {
  final CloudFirestoreSerializable cloudFirestoreConfig;

  const ConnectCloudFirestore({
    this.cloudFirestoreConfig,
  });
}
