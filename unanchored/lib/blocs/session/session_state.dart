import 'package:equatable/equatable.dart';
import 'package:unanchored/models/models.dart';

abstract class SessionState extends Equatable {
  final bool signedIn;
  final User currentUser;

  const SessionState({
    this.currentUser,
    this.signedIn,
  });

  @override
  List<Object> get props => [currentUser, signedIn];
}

class InitialSessionState extends SessionState {
  InitialSessionState()
      : super(
          signedIn: false,
        );
}

class SignedInState extends SessionState {
  final currentUser;

  SignedInState({this.currentUser})
      : super(
          currentUser: currentUser,
          signedIn: true,
        );

  @override
  List<Object> get props => [signedIn, currentUser];
}

class SignedOutState extends SessionState {
  SignedOutState()
      : super(
          signedIn: false,
        );
}

class SignInFailedState extends SessionState {
  SignInFailedState()
      : super(
          signedIn: false,
        );
}
