import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unanchored/models/models.dart';

class Room extends Base {
  final String connectionCode;
  final List<String> currentUserUuids;
  final String userUuid;
  final String name;

  Room({
    this.connectionCode,
    createdAt,
    this.currentUserUuids = const [],
    this.userUuid,
    this.name,
    uuid,
  }) : super(
          createdAt: createdAt,
          uuid: uuid,
        );

  factory Room.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    return Room(
      connectionCode: snapshot.data['connectionCode'],
      createdAt: snapshot.data['createdAt'],
      currentUserUuids: List<String>.from(snapshot.data['currentUserUuids']),
      userUuid: snapshot.data['userUuid'],
      name: snapshot.data['name'],
      uuid: snapshot.data['uuid'],
    );
  }

  @override
  List<Object> get props => [
        connectionCode,
        createdAt,
        currentUserUuids,
        userUuid,
        name,
        uuid,
      ];

  Room copyWith({
    String connectionCode,
    Timestamp createdAt,
    List<String> currentUserUuids,
    String userUuid,
    String name,
    String uuid,
  }) {
    return Room(
      connectionCode: connectionCode ?? this.connectionCode,
      createdAt: createdAt ?? this.createdAt,
      currentUserUuids: currentUserUuids ?? this.currentUserUuids,
      userUuid: userUuid ?? this.userUuid,
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'connectionCode': connectionCode,
      'createdAt': createdAt,
      'currentUserUuids': currentUserUuids,
      'userUuid': userUuid,
      'name': name,
      'uuid': uuid,
    };
  }
}
