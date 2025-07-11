sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess();
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
