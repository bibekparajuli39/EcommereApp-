import 'package:nana/features/auth/bloc/auth_event.dart';
import 'package:nana/features/auth/bloc/auth_state.dart';
import 'package:nana/features/auth/repositories/auth_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<GoogleLogin>((event, emit) async {
      try {
        emit(AuthLoading());
        final response = await repository.googleLogin();
        final user = response.user;

        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthError("Google Login failed"));
        }
      } catch (e, stackTrace) {
        print('GOOGLE LOGIN ERROR: $e');

        print('STACK TRACE: $stackTrace');

        emit(AuthError(e.toString()));
      }
    });
    on<Logout>((event, emit) async {
      try {
        emit(AuthLoading());
        await repository.logout();
        emit(AuthLogout());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
