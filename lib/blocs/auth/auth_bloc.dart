import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/services/services.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authService) : super(Unauthenticated()) {
    on<LoginWithEmail>(_onLoginWithEmail);
    on<SignupWithEmail>(_onSignupWithEmail);
    on<Logout>(_onLogout);
  }

  final AuthService authService;

  final loginKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();

  bool isLoggedIn() => authService.isLoggedIn();

  void _onLoginWithEmail(LoginWithEmail event, Emitter<AuthState> emit) async {
    try {
      if (!(loginKey.currentState?.validate() ?? false)) {
        return;
      }
      final user = await authService.loginUser(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } on AppException catch (e) {
      emit(AuthError(e.message));
    }
  }

  void _onSignupWithEmail(SignupWithEmail event, Emitter<AuthState> emit) async {
    try {
      if (!(signupKey.currentState?.validate() ?? false)) {
        return;
      }
      final user = await authService.signupUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } on AppException catch (e) {
      emit(AuthError(e.message));
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) async {
    await authService.signOut();
    emit(Unauthenticated());
  }
}
