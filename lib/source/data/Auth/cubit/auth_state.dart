part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthGetSession extends AuthState {
  final String? username;

  AuthGetSession({this.username});
}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final int? statusCode;
  dynamic json;

  AuthLoaded({this.statusCode, this.json});
}
