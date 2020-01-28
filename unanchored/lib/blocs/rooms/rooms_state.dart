import 'package:equatable/equatable.dart';
import 'package:unanchored/models/models.dart';

abstract class RoomsState extends Equatable {
  final List<Room> rooms;

  const RoomsState({
    this.rooms,
  });

  @override
  List<Object> get props => [rooms.length];
}

class InitialRoomsState extends RoomsState {
  InitialRoomsState() : super(rooms: []);
}

class RoomsLoadedState extends RoomsState {
  const RoomsLoadedState({rooms}) : super(rooms: rooms);
}
