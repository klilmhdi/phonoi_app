import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/features/02-home/settings/view/setting_page.dart';
import '../../../../core/utils/functions/functions.dart';
import '../../../01-auth/presentation/view/login_screen.dart';
import '../manage/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => SettingsCubit()..fetchUserInfo(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          SettingsCubit cubit = SettingsCubit.get(context);
          return SafeArea(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 14, top: 63),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffDDDDDD),
                              radius: 28,
                              child: Icon(Icons.person_2, size: 50),
                            ),
                          ),
                        ),
                      ),
                      /*
                                            cubit.user == null
                          ? Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(start: 14, top: 63),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.deepPurple,
                                )),
                              ),
                            )
                          :
                       */
                      cubit.userModel != null
                          ? Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(start: 5, top: 63),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("مرحباً ${cubit.userModel!.name.toString()}", style: TextStyle(fontSize: 20)),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (cubit.userModel != null) {
                                              // successDialog(
                                              //   context,
                                              //   "هل متأكد من أنك تريد تسجيل الخروج؟",
                                              //   okText: "موافق",
                                              //   cancelText: "لا",
                                              //   cancelFunction: () => Navigator.pop(context),
                                              //   okFunction: () async => ,
                                              // );AA
                                              await cubit.logout(context);
                                            } else {
                                              await navAndFinish(context, LoginScreen());
                                            }
                                          },
                                          child: Container(
                                            height: 31,
                                            width: 119,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff8C52FF),
                                                borderRadius: BorderRadius.circular(17)),
                                            child: Center(
                                              child: Text(
                                                cubit.userModel != null ? 'تسجيل الخروج' : "تسجيل الدخول",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.notifications_outlined),
                                                iconSize: 23,
                                              ),
                                              IconButton(
                                                onPressed: () => navTo(context, SettingPage()),
                                                icon: const Icon(Icons.settings_outlined),
                                                iconSize: 23,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              flex: 7,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 63),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "مرحباً",
                                              style: TextStyle(fontSize: 31),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        Row(
                                          children: [
                                            Text(
                                              "قم بتسجيل الدخول لمزامنة \nبياناتك والحصول على مزايا",
                                              style: TextStyle(fontSize: 10, color: Color(0xff5D5D5D)),
                                            ),
                                            const SizedBox(width: 65),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 63),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.notifications_outlined),
                                                iconSize: 38,
                                              ),
                                              IconButton(
                                                onPressed: () => navTo(context, SettingPage()),
                                                icon: const Icon(Icons.settings_outlined),
                                                iconSize: 38,
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async => await navAndFinish(context, LoginScreen()),
                                          child: Container(
                                            height: 31,
                                            width: 119,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff8C52FF),
                                                borderRadius: BorderRadius.circular(17)),
                                            child: Center(
                                              child: Text(
                                                "تسجيل الدخول",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 37),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.star,
                                color: Color(0xffFFA000),
                              ),
                              iconSize: 32,
                            ),
                            const Text(
                              'الاشارات المرجعية',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.access_time_filled,
                                color: Color(0xff8C52FF),
                              ),
                              iconSize: 32,
                            ),
                            const Text(
                              'السجل',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.favorite,
                                color: Color(0xffFF002A),
                              ),
                              iconSize: 32,
                            ),
                            const Text(
                              ' الاعجابات',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(Icons.shield_moon, color: Colors.deepPurple, size: 32),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'الاشارات المرجعية',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 51),
                  ListTile(
                    leading: Icon(Icons.facebook),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text("انضم على صفحتنا على الفيس بوك"),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: Icon(Icons.share),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text("شارك phonoi"),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: Icon(Icons.support_agent),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text("مركز المساعدة"),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: Icon(Icons.subscriptions),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text("الاشتراكات"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
