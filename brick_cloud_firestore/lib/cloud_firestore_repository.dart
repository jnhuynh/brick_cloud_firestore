import 'package:brick_cloud_firestore/cloud_firestore_provider.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_core/core.dart';
import 'package:meta/meta.dart';

abstract class CloudFirestoreRepository extends SingleProviderRepository<CloudFirestoreModel> {
  CloudFirestoreRepository({
    @required CloudFirestoreProvider cloudFirestoreProvider,
  }) : super(cloudFirestoreProvider);
}
