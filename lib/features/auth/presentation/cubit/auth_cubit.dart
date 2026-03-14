import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksmok_fe/core/network/session/session_manager.dart';
import 'package:jaksmok_fe/features/auth/domain/repositories/auth_repository.dart';
import 'package:jaksmok_fe/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final SessionManager sessionManager;
  StreamSubscription? sessionSubscription;

  AuthCubit(this.authRepository, this.sessionManager)
    : super(const AuthState.initial()) {
    sessionSubscription = sessionManager.onSessionExpired.listen((_) {
      logout();
    });
    checkAuthStatus();
  }

  @override
  Future<void> close() {
    sessionSubscription?.cancel();
    return super.close();
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(const AuthState.unauthenticated());
  }

  Future<void> login(String username, String password) async {
    emit(const AuthState.loading());

    final result = await authRepository.login(username, password);

    result.fold(
      (failure) {
        emit(AuthState.error(failure.message!));
        emit(const AuthState.unauthenticated());
      },
      (success) {
        emit(const AuthState.success());
        emit(const AuthState.authenticated());
      },
    );
  }

  Future<void> checkAuthStatus() async {
    final token = await authRepository.getToken();
    if (token != null && token.isNotEmpty) {
      emit(AuthState.authenticated());
    } else {
      emit(AuthState.unauthenticated());
    }
  }
}
