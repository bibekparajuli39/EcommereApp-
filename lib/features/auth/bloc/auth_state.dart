import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String? message;

  AuthError(this.message);
}

class AuthAuthenticated extends AuthState {
  final User? user;

  AuthAuthenticated(this.user);
}

class AuthLogout extends AuthState {}
