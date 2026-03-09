import 'package:jaksmok_fe/data/repositories/auth_repository.dart';
import 'package:jaksmok_fe/logic/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInit());

  Future<void> checkAuthStatus() async {
    await authRepository.initalizeAuth();
    final token = await authRepository.getToken();
    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    try {
      final success = await authRepository.login(username, password);
      if (success) {
        emit(AuthSuccess());
        emit(AuthAuthenticated());
      } else {
        emit(AuthError(error: 'Invalid credentials'));
      }
    } catch (error) {
      emit(AuthError(error: 'Something went wrong'));
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
