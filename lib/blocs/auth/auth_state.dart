part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  Authenticated(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
