part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingSignInWithGoogleState extends LoginState {}

class SuccessSignInWithGoogleState extends LoginState {}

class ErrorSignInWithGoogleState extends LoginState {
  ErrorSignInWithGoogleState(String error);
}

class LoadingSignInWithFacebookState extends LoginState {}

class SuccessSignInWithFacebookState extends LoginState {}

class ErrorSignInWithFacebookState extends LoginState {
  ErrorSignInWithFacebookState(String error);
}

class LoadingSignInWithTwitterState extends LoginState {}

class SuccessSignInWithTwitterState extends LoginState {}

class ErrorSignInWithTwitterState extends LoginState {
  ErrorSignInWithTwitterState(String error);
}
