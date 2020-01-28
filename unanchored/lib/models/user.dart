import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unanchored/models/models.dart';

class User extends Base {
  final String authUid;
  final String displayName;

  User({
    this.authUid,
    createdAt,
    this.displayName,
    uuid,
  }) : super(
          createdAt: createdAt,
          uuid: uuid,
        );

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    return User(
      authUid: snapshot.data['authUid'],
      createdAt: snapshot.data['createdAt'],
      displayName: snapshot.data['displayName'],
      uuid: snapshot.data['uuid'],
    );
  }

  @override
  List<Object> get props => [
        authUid,
        createdAt,
        displayName,
        uuid,
      ];

  User copyWith({
    String authUid,
    Timestamp createdAt,
    String displayName,
    String uuid,
  }) {
    return User(
      authUid: authUid ?? this.authUid,
      createdAt: createdAt ?? this.createdAt,
      displayName: displayName ?? this.displayName,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authUid': authUid,
      'createdAt': createdAt,
      'displayName': displayName,
      'uuid': uuid,
    };
  }
}
