import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unanchored/blocs/session/session_state.dart';
import 'package:unanchored/blocs/session/session_event.dart';
import 'package:unanchored/models/models.dart';
import 'package:unanchored/repository.dart';

export 'package:unanchored/blocs/session/session_state.dart';
export 'package:unanchored/blocs/session/session_event.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSession = GoogleSignIn();

  @override
  SessionState get initialState => InitialSessionState();

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    if (event is SignInWithGoogle) yield await _attemptGoogleSignIn(event);

    if (event is SignOutWithGoogle) {
      await _googleSession.signOut();
      yield SignedOutState();
    }
  }

  Future<SessionState> _attemptGoogleSignIn(
    SessionEvent event,
  ) async {
    final GoogleSignInAccount googleSessionAccount = await _googleSession.signIn();
    final GoogleSignInAuthentication googleSessionAuthentication =
        await googleSessionAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSessionAuthentication.accessToken,
      idToken: googleSessionAuthentication.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);

    if (authResult.user.isAnonymous || await authResult.user.getIdToken() == null) {
      return SignInFailedState();
    }

    final FirebaseUser firebaseAuthCurrentUser = await _firebaseAuth.currentUser();

    if (authResult.user.uid != firebaseAuthCurrentUser.uid) {
      return SignInFailedState();
    }

    final user = User(
      displayName: firebaseAuthCurrentUser.displayName,
    );

    Repository().firebaseAuthUser = firebaseAuthCurrentUser;

    var currentUser = await Repository().getUser(user);

    if (currentUser == null) {
      currentUser = await Repository().createUser(user);
    }

    Repository().user = currentUser;

    return SignedInState(
      currentUser: currentUser,
    );
  }
}
