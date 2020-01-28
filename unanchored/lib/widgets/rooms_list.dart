import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unanchored/blocs/room/room_bloc.dart';
import 'package:unanchored/blocs/rooms/rooms_bloc.dart';
import 'package:unanchored/models/models.dart';
import 'package:unanchored/utils/debouncer.dart';

class RoomsList extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsBloc, RoomsState>(
      builder: (BuildContext context, RoomsState state) {
        final rooms = state.rooms;
        rooms.sort((a, b) {
          // Sort by descending createdAt
          return b.createdAt.compareTo(a.createdAt);
        });

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            // TODO: add loading indications everywhere
            _debouncer.run(() {
              if (scrollNotification is UserScrollNotification) {
                final isDownScroll = scrollNotification.metrics.axisDirection == AxisDirection.down;
                final atEdge = scrollNotification.metrics.atEdge;

                if (isDownScroll && atEdge) {
                  BlocProvider.of<RoomsBloc>(context).add(LoadRooms());
                }
              }
            });

            return false;
          },
          child: ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (BuildContext context, int index) {
              return _RoomListRow(
                room: rooms[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _RoomListRow extends StatelessWidget {
  final Room room;

  _RoomListRow({this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${room.name}'),
        subtitle: Text('${room.formattedCreatedAt}'),
        onTap: () {
          BlocProvider.of<RoomBloc>(context).add(
            SelectRoom(
              room: this.room,
            ),
          );
        },
      ),
    );
  }
}
