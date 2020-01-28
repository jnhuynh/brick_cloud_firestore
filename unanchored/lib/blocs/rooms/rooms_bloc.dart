import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:unanchored/blocs/rooms/rooms_event.dart';
import 'package:unanchored/blocs/rooms/rooms_state.dart';
import 'package:unanchored/repository.dart';

export 'package:unanchored/blocs/rooms/rooms_event.dart';
export 'package:unanchored/blocs/rooms/rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  @override
  RoomsState get initialState => InitialRoomsState();

  @override
  Stream<RoomsState> mapEventToState(
    RoomsEvent event,
  ) async* {
    if (event is LoadRooms) {
      final rooms = await Repository().getRooms();

      yield RoomsLoadedState(
        rooms: rooms,
      );
    }
  }
}
