part of 'auth_cubit_cubit.dart';

abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitUser extends AuthCubitState {
  final User user;
  final Baby baby;
  final List<Baby> babies;
  AuthCubitUser(this.user, this.baby, this.babies);
}

class AuthCubitNoUser extends AuthCubitState {}
