import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/features/02-home/0-layout/manage/app_layout/app_layout_cubit.dart';

import '../../../../generated/l10n.dart';

class Layout extends StatefulWidget {
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => AppLayoutCubit(),
      child: BlocBuilder<AppLayoutCubit, AppLayoutState>(
        builder: (context, state) {
          var cubit = AppLayoutCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: S.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.language_outlined),
                  activeIcon: Icon(Icons.language),
                  label: S.of(context).explore,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.folder_special_outlined),
                  activeIcon: Icon(Icons.folder_special),
                  label: S.of(context).files,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  activeIcon: Icon(Icons.person),
                  label: S.of(context).me,
                ),
              ],
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor: const Color(0xff8C52FF),
              selectedIconTheme: const IconThemeData(color: Color(0xff8C52FF)),
              onTap: (index) => cubit.changeBottomNavBar(index),
            ),
          );
        },
      ),
    );
  }
}
