part of 'auth_bloc.dart';

enum AuthStatus { loading, success, failed }

class AuthState extends Equatable {
  final String? username;
  final String? password;
  final String? email;
  final String? shopName;
  final Me? me;
  final String? errorMessage;
  final AuthStatus authStatus;

  const AuthState({
    this.email,
    this.shopName,
    this.username,
    this.password,
    this.me,
    this.errorMessage,
    this.authStatus = AuthStatus.loading,
  });

  AuthState copyWith({
    String? username,
    String? password,
    String? email,
    String? shopName,
    Me? me,
    String? errorMessage,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      shopName: shopName ?? this.shopName,
      me: me ?? this.me,
      errorMessage: errorMessage ?? this.errorMessage,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props =>
      [username, password, email, shopName, me, errorMessage, authStatus];
}
