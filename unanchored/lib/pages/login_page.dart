import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unanchored/blocs/session/session_bloc.dart';
import 'package:unanchored/utils/router.dart';
import 'package:unanchored/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      condition: (previousState, state) {
        return state is SignedInState;
      },
      listener: (context, state) {
        Navigator.pushReplacementNamed(context, Router.home);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 150),
                SizedBox(height: 50),
                StrokedButton(
                  icon: FontAwesomeIcons.google,
                  text: 'Sign in with Google',
                  onPressed: () {
                    BlocProvider.of<SessionBloc>(context).add(
                      SignInWithGoogle(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
