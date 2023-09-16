import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../01-home_webview/presentation/view/home_screen.dart';
import '../../../2-games_suggestions/presentation/view/explore_screen.dart';
import '../../../3-files/view/files_screen.dart';
import '../../../4-settings/view/settings_screen.dart';

part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  AppLayoutCubit() : super(AppLayoutInitial());

  static AppLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  // List<Widget> screens = [HomeScreen(), ExploreScreen(), FilesScreen(), OpenTabsScreen(), SettingsScreen()];
  List<Widget> screens = [HomeScreen(), ExploreScreen(), FilesScreen(), SettingsScreen()];
  // List<Widget> screens = [HomeScreen(), ExploreScreen(), FilesPage(), SettingsScreen()];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "الرئيسية",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.language_outlined),
      activeIcon: Icon(Icons.language),
      label: "استكشف",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.folder_special_outlined),
      activeIcon: Icon(Icons.folder_special),
      label: "الملفات",
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.tab_outlined),
    //   activeIcon: Icon(Icons.tab),
    //   label: "التبويب",
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_outlined),
      activeIcon: Icon(Icons.person),
      label: "أنا",
    ),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarState(index));
  }
}
