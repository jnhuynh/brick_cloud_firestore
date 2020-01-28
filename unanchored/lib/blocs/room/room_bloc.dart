import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:unanchored/blocs/room/room_event.dart';
import 'package:unanchored/blocs/room/room_state.dart';
import 'package:unanchored/models/models.dart';
import 'package:unanchored/repository.dart';
import 'package:uuid/uuid.dart';

export 'package:unanchored/blocs/room/room_event.dart';
export 'package:unanchored/blocs/room/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  @override
  RoomState get initialState => InitialRoomState();

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is CreateRoom) {
      final room = await _createRoom(event.name);

      yield RoomSelectedState(
        currentRoom: await _addCurrentUserToRoom(room),
      );
    }

    if (event is SelectRoom) {
      yield RoomSelectedState(
        currentRoom: await _addCurrentUserToRoom(event.room),
      );
    }

    if (event is LeaveRoom) {
      await _removeCurrentUserFromRoom(event.room);
      yield InitialRoomState();
    }
  }

  // Use cases
  Future<Room> _createRoom(String name) {
    final newRoom = Room(
      connectionCode: Uuid().v4().split('-').first,
      name: name,
    );

    return Repository().saveRoom(newRoom);
  }

  Future<Room> _addCurrentUserToRoom(Room room) {
    final currentUserUuids = room.currentUserUuids;
    currentUserUuids.add(Repository().user.uuid);

    final updated = room.copyWith(
      currentUserUuids: currentUserUuids.toSet().toList(),
    );

    return Repository().saveRoom(updated);
  }

  Future<Room> _removeCurrentUserFromRoom(Room room) {
    final currentUserUuids = room.currentUserUuids;
    currentUserUuids.remove(Repository().user.uuid);

    final updated = room.copyWith(
      currentUserUuids: currentUserUuids.toSet().toList(),
    );

    return Repository().saveRoom(updated);
  }
}
