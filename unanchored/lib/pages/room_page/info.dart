import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unanchored/blocs/room/room_bloc.dart';
import 'package:unanchored/widgets/widgets.dart';

class RoomPageInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTitle(context),
          _buildConnectionCode(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final room = BlocProvider.of<RoomBloc>(context).state.currentRoom;

    return PaddedCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Title',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Text(
            room.name,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionCode(BuildContext context) {
    final room = BlocProvider.of<RoomBloc>(context).state.currentRoom;

    return PaddedCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Connection Code',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Text(
            room.connectionCode,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }
}
