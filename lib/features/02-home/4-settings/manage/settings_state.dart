part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class LogoutSuccessState extends SettingsState {}

class LogoutLoadingState extends SettingsState {}

class SuccessFetchingDataState extends SettingsState {
  SuccessFetchingDataState(UserModel userModel);
}

class ErrorFetchingDataState extends SettingsState {
  ErrorFetchingDataState(String error);
}

class LoadingFetchingDataState extends SettingsState {}
