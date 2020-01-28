import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unanchored/blocs/room/room_bloc.dart';
import 'package:unanchored/blocs/rooms/rooms_bloc.dart';
import 'package:unanchored/blocs/session/session_bloc.dart';
import 'package:unanchored/utils/router.dart';
import 'package:unanchored/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static final List<Map<String, String>> appBarPopupChoices = [
    {
      'value': 'signOut',
      'title': 'Sign Out',
    },
  ];

  static final Map<String, int> homePageTabs = {
    'home': 0,
    'createRoom': 1,
  };

  int _currentTabIndex = homePageTabs['home'];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoomsBloc>(context).add(LoadRooms());
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = _buildAppBar();
    final _bottomTabBar = _buildBottomTabBar();
    final _body = _buildBody();

    return MultiBlocListener(
      child: Scaffold(
        appBar: _appBar,
        body: _body,
        bottomNavigationBar: _bottomTabBar,
      ),
      listeners: <BlocListener>[
        BlocListener<SessionBloc, SessionState>(
          condition: (previousState, state) => state is SignedOutState,
          listener: (context, state) => Navigator.pushReplacementNamed(context, Router.login),
        ),
        BlocListener<RoomBloc, RoomState>(
          condition: (previousState, state) => state is RoomSelectedState,
          listener: (context, state) {
            // Reload rooms and reset to home tab when a room is selected
            BlocProvider.of<RoomsBloc>(context).add(LoadRooms());

            setState(() {
              _currentTabIndex = homePageTabs['home'];
            });

            Navigator.pushNamed(context, Router.room);
          },
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Unanchored'),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (choiceValue) {
            if (choiceValue == 'signOut') {
              BlocProvider.of<SessionBloc>(context).add(
                SignOutWithGoogle(),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return appBarPopupChoices.map((choice) {
              return PopupMenuItem(
                value: choice['value'],
                child: Text(choice['title']),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_currentTabIndex == homePageTabs['home']) {
      return RoomsList();
    } else if (_currentTabIndex == homePageTabs['createRoom']) {
      return CreateRoomForm();
    } else {
      return const Text('Cant find that tab bro');
    }
  }

  BottomNavigationBar _buildBottomTabBar() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
      currentIndex: _currentTabIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: const Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: const Text('Create Room'),
        ),
      ],
    );
  }
}
