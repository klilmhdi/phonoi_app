import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/features/02-home/0-layout/manage/app_layout/app_layout_cubit.dart';
import 'package:phonoi_app/features/02-home/3-files/view/downloads_screen.dart';

import '../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../../generated/l10n.dart';
import '../../01-home_webview/presentation/view/add_download_link_screen.dart';

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
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.add),
              onPressed: () {
                if (cubit.user == null) {
                  print("Didn't find the users");
                  showErrorSnackBar(S.of(context).go_to_sign_up, 4, context);
                } else {
                  navToForFloatingActionButton(context, AddLinkDownloadedScreen());
                }
              },
              backgroundColor: Colors.deepPurple,
            ),
          );
        },
      ),
    );
  }
}
