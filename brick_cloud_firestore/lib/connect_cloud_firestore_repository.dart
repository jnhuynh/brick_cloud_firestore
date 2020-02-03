import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_core/core.dart';

class ConnectCloudFirestoreRepository extends SingleProviderRepository<CloudFirestoreModel> {
  ConnectCloudFirestoreRepository() : super(CloudFirestoreProvider());
}
