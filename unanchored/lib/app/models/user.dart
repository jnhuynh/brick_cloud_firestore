import 'package:brick_cloud_firestore/cloud_firestore.dart';

@CloudFirestoreSerializable()
class User extends CloudFirestoreModel {
  final String uid;

  User({
    this.uid,
  });
}
