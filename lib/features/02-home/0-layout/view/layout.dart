import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/features/02-home/0-layout/manage/app_layout/app_layout_cubit.dart';

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
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedItemColor: const Color(0xff8C52FF),
              selectedIconTheme: const IconThemeData(color: Color(0xff8C52FF)),
              unselectedItemColor: Colors.grey.shade900,
              unselectedIconTheme: const IconThemeData(color: Color(0xff000000)),
              onTap: (index) => cubit.changeBottomNavBar(index),
            ),
          );
        },
      ),
    );
  }
}
