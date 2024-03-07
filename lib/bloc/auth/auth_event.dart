part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final User payload;
  LoginEvent(this.payload);
}

class RegisterEvent extends AuthEvent {
  final User payload;
  RegisterEvent(this.payload);
}

class MeEvent extends AuthEvent {}
