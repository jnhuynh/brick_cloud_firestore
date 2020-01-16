import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_core/core.dart' as brick;

class FirebaseModelDictionary
    extends brick.ModelDictionary<FirebaseModel, FirebaseAdapter<FirebaseModel>> {
  const FirebaseModelDictionary(Map<Type, FirebaseAdapter<FirebaseModel>> mappings)
      : super(mappings);
}

class FirebaseProvider implements brick.Provider<FirebaseModel> {
  final FirebaseModelDictionary modelDictionary;

  // TODO: require this later on
  // FirebaseUser firebaseAuthUser;
  // User user;

  FirebaseProvider({
    this.modelDictionary,
  });

  @override
  Future<bool> delete<T extends FirebaseModel>(T instance,
      {brick.Query query, brick.ModelRepository<FirebaseModel> repository}) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<List<T>> get<T extends FirebaseModel>(
      {brick.Query query, brick.ModelRepository<FirebaseModel> repository}) async {
    // final adapter = modelDictionary.adapterFor[T];

    // // TODO: node name from adapter/model
    // CollectionReference roomCollection = Firestore.instance.collection('room');
    // Query query = roomCollection.where('userUuid', isEqualTo: user.uuid);
    // QuerySnapshot querySnapshot = await query.getDocuments();

    // return querySnapshot.documents.map((DocumentSnapshot snapshot) {
    //   return adapter.fromSnapshot(snapshot);
    // }).toList();
    return null;
  }

  @override
  Future<bool> upsert<T extends FirebaseModel>(T instance,
      {brick.Query query, brick.ModelRepository<FirebaseModel> repository}) {
    return null;
    // final json = _buildJson(room);

    // CollectionReference roomCollection = _firestore.collection(_modelCollectionMap[Room]);
    // DocumentReference ref = roomCollection.document(json['uuid']);

    // await ref.setData(json);
    // final snapshot = await ref.get();

    // return Room.fromSnapshot(snapshot);
    // return null;

    //     final adapter = modelDictionary.adapterFor[_Model];
    // final body = await adapter.toRest(instance, provider: this, repository: repository);

    // final url = urlForModel<_Model>(query, instance);
    // final resp = await _sendUpsertResponse(url, body, query, adapter.toKey);

    // _logger.finest("caller=upsert url=$url statusCode=${resp?.statusCode} body=${resp?.body}");

    // if (statusCodeIsSuccessful(resp?.statusCode)) {
    //   return resp;
    // } else {
    //   _logger.warning(resp?.statusCode, resp?.body);
    //   throw RestException(resp);

    /// Sends serialized model data to an endpoint
    // Future<http.Response> _sendUpsertResponse(
    //   String url,
    //   Map<String, dynamic> body, [
    //   Query query,
    //   String toKey,
    // ]) async {
    //   final encodedBody = jsonEncode(body);
    //   final topLevelKey = (query?.params ?? {})['topLevelKey'] ?? toKey;
    //   final wrappedBody = topLevelKey != null ? '{"$topLevelKey":$encodedBody}' : encodedBody;
    //   final headers = headersForQuery(query);

    //   if ((query?.params ?? {})['request'] == 'PUT') {
    //     _logger.fine("PUT $url");
    //     _logger.finer("method=PUT url=$url headers=$headers body=$wrappedBody");
    //     return await client.put(url, body: wrappedBody, headers: headers);
    //   }

    //   _logger.fine("POST $url");
    //   _logger.finer("method=POST url=$url headers=$headers body=$wrappedBody");
    //   return await client.post(url, body: wrappedBody, headers: headers);
    // }
  }
}

abstract class FirebaseAdapter<_Model extends brick.Model> implements brick.Adapter<_Model> {
  /// Retrieves data under this key when deserializing
  String get fromKey;

  /// Submits data under this key when serializing
  String get toKey;

  Future<_Model> fromFirebase(
    Map<String, dynamic> data, {
    FirebaseProvider provider,
    brick.ModelRepository<FirebaseModel> repository,
  });
  Future<Map<String, dynamic>> toFirebase(
    _Model instance, {
    FirebaseProvider provider,
    brick.ModelRepository<FirebaseModel> repository,
  });
}
