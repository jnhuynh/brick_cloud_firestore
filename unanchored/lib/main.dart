import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:unanchored/blocs/room/room_bloc.dart';
import 'package:unanchored/blocs/rooms/rooms_bloc.dart';
import 'package:unanchored/blocs/session/session_bloc.dart';
import 'package:unanchored/blocs/simple_bloc_delegate.dart';
import 'package:unanchored/pages/pages.dart';
import 'package:unanchored/utils/router.dart';

void main() => runApp(Unanchored());

class Unanchored extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SimpleBlocDelegate();

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(
          create: (BuildContext context) => RoomBloc(),
        ),
        BlocProvider<RoomsBloc>(
          create: (BuildContext context) => RoomsBloc(),
        ),
        BlocProvider<SessionBloc>(
          create: (BuildContext context) => SessionBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Unanchored',
        theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.grey,
          textTheme: TextTheme(
            title: TextStyle(
              height: 2,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        home: LoginPage(),
        routes: Router.routes,
      ),
    );
  }
}
