part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginWithEmail extends AuthEvent {
  LoginWithEmail(this.email, this.password);

  final String email;
  final String password;
}

class SignupWithEmail extends AuthEvent {
  SignupWithEmail(this.name, this.email, this.password);

  final String name;
  final String email;
  final String password;
}

class Logout extends AuthEvent {}
