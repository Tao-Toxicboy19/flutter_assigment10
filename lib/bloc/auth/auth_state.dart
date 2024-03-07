part of 'auth_bloc.dart';

enum AuthStatus { loading, success, failed }

class AuthState extends Equatable {
  final String? username;
  final String? password;
  final Me? me;
  final String? errorMessage;
  final AuthStatus authStatus;

  const AuthState({
    this.username,
    this.password,
    this.me,
    this.errorMessage,
    this.authStatus = AuthStatus.loading,
  });

  AuthState copyWith({
    String? username,
    String? password,
    Me? me,
    String? errorMessage,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      username: username ?? this.username,
      password: password ?? this.password,
      me: me ?? this.me,
      errorMessage: errorMessage ?? this.errorMessage,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [username, password, me, errorMessage, authStatus];
}
