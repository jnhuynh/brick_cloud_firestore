import 'package:equatable/equatable.dart';

abstract class SessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInWithGoogle extends SessionEvent {}

class SignOutWithGoogle extends SessionEvent {}
