part of 'auth_cubit_cubit.dart';

abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitUser extends AuthCubitState {
  final User user;
  final Baby baby;
  AuthCubitUser(this.user, this.baby);
}

class AuthCubitNoUser extends AuthCubitState {}
