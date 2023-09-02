part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class LoadingCreateUserState extends SignupState {}

class SuccessCreateUserState extends SignupState {}

class ErrorCreateUserState extends SignupState {
  ErrorCreateUserState(String error);
}
