import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:phonoi_app/core/utils/widgets/dialoges.dart';
import 'package:phonoi_app/features/02-home/4-settings/view/setting_page.dart';
import '../../../../core/app-cubit/app_cubit/app_cubit/app_cubit.dart';
import '../../../../core/app-cubit/themes/theme_cubit.dart';
import '../../../../core/utils/functions/functions.dart';
import '../../../../generated/l10n.dart';
import '../../../01-auth/presentation/view/login_screen.dart';
import '../manage/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin {
  @override
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
                      cubit.userModel != null
                          ? Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(start: 5, top: 63),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${S.of(context).hello + ": " + cubit.userModel!.name.toString()}",
                                        style: TextStyle(fontSize: 20)),
                                    GestureDetector(
                                      onTap: () async => cancelLogoutWarningAlert(context, cubit.logout(context)),
                                      child: Container(
                                        height: 31,
                                        width: 119,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff8C52FF), borderRadius: BorderRadius.circular(17)),
                                        child: Center(
                                          child: Text(
                                            S.of(context).log_out,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              flex: 7,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 63),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          S.of(context).hello,
                                          style: TextStyle(fontSize: 31),
                                        ),
                                        AutoSizeText(
                                          S.of(context).sign_in_title,
                                          maxLines: 3,
                                          style: TextStyle(fontSize: 10, color: Color(0xff5D5D5D)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 63),
                                    child: GestureDetector(
                                      onTap: () async => await navAndFinish(context, LoginScreen()),
                                      child: Container(
                                        height: 31,
                                        width: 119,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff8C52FF), borderRadius: BorderRadius.circular(17)),
                                        child: Center(
                                          child: Text(
                                            S.of(context).log_in,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 51),
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: CupertinoColors.activeBlue,
                        child: Icon(
                          Icons.facebook,
                          color: Colors.white,
                        )),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text(S.of(context).join_us),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    onTap: () => navTo(context, SettingPage()),
                    leading: CircleAvatar(
                        backgroundColor: CupertinoColors.systemYellow,
                        child: Icon(
                          Icons.settings,
                          color: Colors.black87,
                        )),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text(S.of(context).settings),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          FontAwesome.reply,
                          color: Colors.white,
                        )),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text(S.of(context).share_app),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.black87,
                        child: Icon(
                          Icons.support_agent,
                          color: Colors.white,
                        )),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xff5D5D5D),
                    ),
                    title: Text(S.of(context).help_center),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading:
                        CircleAvatar(backgroundColor: Colors.deepOrange, child: Icon(Icons.sunny, color: Colors.white)),
                    title: Text(S.of(context).change_theme),
                    trailing: BlocBuilder<AppCubit, AppState>(
                      buildWhen: (previous, current) => previous.themeCurrentIndex != current.themeCurrentIndex,
                      builder: (context, state) {
                        AppCubit appCubit = BlocProvider.of(context, listen: false);

                        return Switch.adaptive(
                            activeColor: Colors.deepPurple,
                            //=========> 0 Light
                            value: state.themeCurrentIndex == 0,
                            onChanged: (value) {
                              if (state.themeCurrentIndex == 0) {
                                appCubit.setThemeIndex(themeIndex: 1);
                              } else {
                                appCubit.setThemeIndex(themeIndex: 0);
                              }
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
