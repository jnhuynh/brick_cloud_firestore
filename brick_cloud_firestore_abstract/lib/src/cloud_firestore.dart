import 'package:brick_cloud_firestore_abstract/annotations.dart';

/// An annotation used to specify a class to generate code for.
class CloudFirestore {
  final CloudFirestoreSerializable cloudFirestoreConfig;

  const CloudFirestore({
    this.cloudFirestoreConfig,
  });

  static const defaults = CloudFirestore(
    cloudFirestoreConfig: CloudFirestoreSerializable.defaults,
  );

  CloudFirestore withDefaults() => CloudFirestore(
        cloudFirestoreConfig: cloudFirestoreConfig ?? defaults.cloudFirestoreConfig,
      );
}
