import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unanchored/models/models.dart';

abstract class RoomEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateRoom extends RoomEvent {
  final String name;

  CreateRoom({
    @required this.name,
  }) : super();

  @override
  List<Object> get props => [name];
}

class LeaveRoom extends RoomEvent {
  final Room room;

  LeaveRoom({
    @required this.room,
  }) : super();

  @override
  List<Object> get props => [room];
}

class SelectRoom extends RoomEvent {
  final Room room;

  SelectRoom({
    @required this.room,
  }) : super();

  @override
  List<Object> get props => [room];
}
