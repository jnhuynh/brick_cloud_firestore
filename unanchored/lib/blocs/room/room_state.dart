import 'package:equatable/equatable.dart';
import 'package:unanchored/models/models.dart';

abstract class RoomState extends Equatable {
  final Room currentRoom;

  const RoomState({
    this.currentRoom,
  });

  @override
  List<Object> get props => [currentRoom];
}

class InitialRoomState extends RoomState {
  InitialRoomState() : super(currentRoom: null);
}

class RoomSelectedState extends RoomState {
  const RoomSelectedState({currentRoom}) : super(currentRoom: currentRoom);
}
