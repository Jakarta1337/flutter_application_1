part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
