import 'package:equatable/equatable.dart';

abstract class RoomsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRooms extends RoomsEvent {}
