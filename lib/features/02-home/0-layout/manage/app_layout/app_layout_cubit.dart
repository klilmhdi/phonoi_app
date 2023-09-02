import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../1-home_webview/view/home_screen.dart';
import '../../../2-games_suggestions/view/explore_screen.dart';
import '../../../3-files/view/file_screen.dart';
import '../../../4-open_new_tab/view/open_tabs_screen.dart';
import '../../../settings/view/settings_screen.dart';

part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  AppLayoutCubit() : super(AppLayoutInitial());

  static AppLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  // List<Widget> screens = [HomeScreen(), ExploreScreen(), FilesScreen(), OpenTabsScreen(), SettingsScreen()];
  List<Widget> screens = [HomeScreen(), ExploreScreen(), FilesScreen(), SettingsScreen()];
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
