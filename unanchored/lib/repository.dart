import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unanchored/models/models.dart';
import 'package:uuid/uuid.dart';

class Repository {
  final _firestore = Firestore.instance;
  final _modelCollectionMap = {
    User: 'users',
    Room: 'rooms',
  };

  FirebaseUser firebaseAuthUser;
  User user;

  static Repository _instance;

  Repository._();

  factory Repository() {
    _instance ??= Repository._();

    return _instance;
  }

  Future<Room> saveRoom(Room room) async {
    final json = _buildJson(room);

    CollectionReference roomCollection = _firestore.collection(_modelCollectionMap[Room]);
    DocumentReference ref = roomCollection.document(json['uuid']);

    await ref.setData(json);
    final snapshot = await ref.get();

    return Room.fromSnapshot(snapshot);
  }

  Future<List<Room>> getRooms() async {
    CollectionReference roomCollection = _firestore.collection(_modelCollectionMap[Room]);
    Query query = roomCollection.where('userUuid', isEqualTo: user.uuid);
    QuerySnapshot querySnapshot = await query.getDocuments();

    return querySnapshot.documents.map((DocumentSnapshot snapshot) {
      return Room.fromSnapshot(snapshot);
    }).toList();
  }

  Future<User> getUser(User user) async {
    CollectionReference userCollection = _firestore.collection(_modelCollectionMap[User]);
    Query query = userCollection.where('authUid', isEqualTo: user.authUid).limit(1);

    QuerySnapshot querySnapshot = await query.getDocuments();

    if (querySnapshot.documents.length > 0) {
      DocumentSnapshot snapshot = querySnapshot.documents.first;

      return User.fromSnapshot(snapshot);
    } else {
      return null;
    }
  }

  Future<User> createUser(User user) async {
    final json = _buildJson(user);

    CollectionReference userCollection = _firestore.collection(_modelCollectionMap[User]);
    DocumentReference ref = userCollection.document(json['uuid']);

    await ref.setData(json);
    final snapshot = await ref.get();

    print(ref.documentID);

    return User.fromSnapshot(snapshot);
  }

  Map<String, dynamic> _buildJson(Base model) {
    final json = model.toJson();

    if (json['uuid'] == null) {
      json['uuid'] = Uuid().v4();
    }

    if (json['createdAt'] == null) {
      json['createdAt'] = Timestamp.now();
    }

    if (model is! User && json['userUuid'] == null) {
      json['userUuid'] = user.uuid;
    }

    if (model is User) {
      json['authUid'] = firebaseAuthUser.uid;
    }

    return json;
  }
}
