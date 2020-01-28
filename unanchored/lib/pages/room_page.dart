import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:unanchored/blocs/room/room_bloc.dart';
import 'package:unanchored/pages/room_page/info.dart';
import 'package:unanchored/pages/room_page/vote.dart';

class RoomPage extends StatelessWidget {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<RoomBloc>(context).add(
          LeaveRoom(
            room: BlocProvider.of<RoomBloc>(context).state.currentRoom,
          ),
        );

        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Unanchored')),
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _currentPageNotifier.value = index;
              },
              children: <Widget>[
                RoomPageInfo(),
                RoomPageVote(),
              ],
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CirclePageIndicator(
                  itemCount: 2,
                  currentPageNotifier: _currentPageNotifier,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
