abstract class AuthState {}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {}
