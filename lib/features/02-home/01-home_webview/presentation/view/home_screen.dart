import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/core/utils/widgets/snackbars_widgets.dart';
import 'package:phonoi_app/features/02-home/01-home_webview/presentation/widgets/web_view.dart';
import 'package:phonoi_app/generated/assets.dart';

import '../../../../../core/utils/functions/functions.dart';
import '../../../../../generated/l10n.dart';
import '../manage/home/home_cubit.dart';
import '../widgets/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final HomeCubit cubit = context.read<HomeCubit>();
          cubit.getItems(context);
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 36.h,
                      start: 74.w,
                      end: 73.w,
                    ),
                    child: SizedBox(
                      width: 228.w,
                      height: 228.h,
                      child: Image.asset(Assets.appIconsAppIcon),
                    ),
                  ),
                  TextField(
                    onTap: () {
                      navTo(context, SearchScreen());
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 50.h, maxWidth: 347.w),
                      fillColor: const Color(0xffEBEBEB),
                      filled: true,
                      hintText: S.of(context).search,
                      hintStyle: TextStyle(fontSize: 10.sp, color: Colors.black87),
                      prefixIcon: SizedBox(
                        width: 6.5.w,
                        height: 6.5.h,
                        child: Image.asset("assets/icons/google.png"),
                      ),
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    ),
                  ),
                  Container(
                    height: 300.0,
                    width: double.infinity,
                    child: GridView.builder(
                      itemCount: cubit.getItems(context).length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, crossAxisSpacing: 2.0, mainAxisSpacing: 5.0),
                      itemBuilder: (context, index) {
                        final items = cubit.getItems(context)[index];
                        return Column(
                          children: [
                            IconButton(
                              onPressed: () => navTo(context, WebViewPage(url: items.url)),
                              icon: Image.asset(items.imagesName, width: 41, height: 41),
                            ),
                            Text(
                              items.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
