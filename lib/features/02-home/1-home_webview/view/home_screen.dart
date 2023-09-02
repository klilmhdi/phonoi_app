import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/features/02-home/1-home_webview/widgets/divider_widget.dart';
import 'package:phonoi_app/features/02-home/1-home_webview/widgets/search_screen.dart';
import 'package:phonoi_app/generated/assets.dart';

import '../../../../core/utils/functions/functions.dart';
import '../../../../core/utils/widgets/home_column_widgets.dart';
import '../manage/home/home_cubit.dart';
import '../widgets/web_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
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
                SizedBox(
                  width: 351.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onTap: () {
                          navTo(context, SearchScreen());
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 50.h, maxWidth: 347.w),
                          fillColor: const Color(0xffEBEBEB),
                          filled: true,
                          hintText: "البحث أو كتابة عنوان الويب",
                          hintStyle: TextStyle(
                            color: const Color(0xff5D5D5D),
                            fontSize: 13.sp,
                          ),
                          prefixIcon: SizedBox(
                            width: 10.5.w,
                            height: 10.5.h,
                            child: Image.asset("assets/icons/google.png"),
                          ),
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                        ),
                      ),
                      buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("في حال تريد تحميل الرابط بشكل مباشر,", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
                          TextButton(child: Text('اذهب الى هنا', style: TextStyle(color: Colors.blue)), onPressed: ()=> Navigator.pushNamed(context, '/add_download_link_screen')),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          HomeColumnWidgets(
                            imagesName: "youtube",
                            name: "YouTube",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: "https://www.YouTube.com"),
                                ),
                              );
                            },
                          ),
                          HomeColumnWidgets(
                            imagesName: "facebook",
                            name: "Facebook",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: "https://www.facebook.com"),
                                ),
                              );
                            },
                          ),
                          HomeColumnWidgets(
                            imagesName: "twitter",
                            name: "Twitter",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: "https://www.Twitter.com"),
                                ),
                              );
                            },
                          ),
                          HomeColumnWidgets(
                            imagesName: "instagram",
                            name: "Instagram",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: "https://www.Instagram.com"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: HomeColumnWidgets(
                              imagesName: "sama",
                              name: "samaNews",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewPage(url: "https://www.samanews.ps/ar/"),
                                  ),
                                );
                              },
                            ),
                          ),
                          HomeColumnWidgets(
                            imagesName: "palsawa",
                            name: "palsawa",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: "https://palsawa.com/"),
                                ),
                              );
                            },
                          ),
                          HomeColumnWidgets(
                            imagesName: "alwatan",
                            name: "wattan.net",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: "https://www.wattan.net/ar/"),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
