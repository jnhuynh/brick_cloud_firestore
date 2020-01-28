import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unanchored/models/models.dart';

class Story extends Base {
  final String name;
  final String roomUuid;

  Story({
    createdAt,
    this.name,
    this.roomUuid,
    uuid,
  }) : super(
          createdAt: createdAt,
          uuid: uuid,
        );

  factory Story.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    return Story(
      createdAt: snapshot.data['createdAt'],
      name: snapshot.data['name'],
      roomUuid: snapshot.data['roomUuid'],
      uuid: snapshot.data['uuid'],
    );
  }

  @override
  List<Object> get props => [
        createdAt,
        roomUuid,
        name,
        uuid,
      ];

  Story copyWith({
    Timestamp createdAt,
    String name,
    String roomUuid,
    String uuid,
  }) {
    return Story(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      roomUuid: roomUuid ?? this.roomUuid,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'roomUuid': roomUuid,
      'name': name,
      'uuid': uuid,
    };
  }
}
