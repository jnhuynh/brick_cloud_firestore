import 'package:brick_cloud_firestore/cloud_firestore_model_dictionary.dart';
import 'package:brick_cloud_firestore/src/query_cloud_firestore_transformer.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_core/core.dart' as brick;
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreProvider implements brick.Provider<CloudFirestoreModel> {
  final CloudFirestoreModelDictionary modelDictionary;

  // TODO: require this later on
  // CloudFirestoreUser firebaseAuthUser;
  // User user;

  CloudFirestoreProvider({
    this.modelDictionary,
  });

  @override
  Future<bool> delete<T extends CloudFirestoreModel>(instance, {query, repository}) async {
    assert(instance.documentId != null, 'Instance has not been sent or received from Firestore');
    final adapter = modelDictionary.adapterFor[T];

    final document =
        Firestore.instance.collection(adapter.collectionNodeKey).document(instance.documentId);

    try {
      await document.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<T>> get<T extends CloudFirestoreModel>({query, repository}) async {
    final adapter = modelDictionary.adapterFor[T];

    final collection = Firestore.instance.collection(adapter.collectionNodeKey);
    final firebaseQuery = QueryCloudFirestoreTransformer(query, collection).asFirebaseQuery;
    final snapshot = await firebaseQuery.getDocuments();

    final futureDocuments = snapshot.documents.map<Future<T>>((snapshot) {
      return adapter.fromCloudFirestore(
        (snapshot.data ?? {})
          ..addAll({CloudFirestoreModel.DOCUMENT_ID_FIELD_NAME: snapshot.documentID}),
        provider: this,
        repository: repository,
      );
    });

    return await Future.wait<T>(futureDocuments);
  }

  @override
  Future<T> upsert<T extends CloudFirestoreModel>(instance, {query, repository}) async {
    final adapter = modelDictionary.adapterFor[T];

    final collection = Firestore.instance.collection(adapter.collectionNodeKey);
    final document = collection.document();
    final data = await adapter.toCloudFirestore(instance, provider: this, repository: repository);
    await document.setData(data);

    return instance..documentId = document.documentID;
  }
}
