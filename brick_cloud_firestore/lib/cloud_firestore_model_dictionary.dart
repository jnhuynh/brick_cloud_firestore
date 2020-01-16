import 'package:brick_cloud_firestore/cloud_firestore_adapter.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_core/core.dart';

class CloudFirestoreModelDictionary
    extends ModelDictionary<CloudFirestoreModel, CloudFirestoreAdapter<CloudFirestoreModel>> {
  const CloudFirestoreModelDictionary(
      Map<Type, CloudFirestoreAdapter<CloudFirestoreModel>> mappings)
      : super(mappings);
}
