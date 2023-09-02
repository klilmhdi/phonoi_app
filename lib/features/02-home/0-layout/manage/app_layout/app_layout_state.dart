part of 'app_layout_cubit.dart';

@immutable
abstract class AppLayoutState {}

class AppLayoutInitial extends AppLayoutState {}

class ChangeBottomNavigationBarState extends AppLayoutState {
  ChangeBottomNavigationBarState(index);
}
