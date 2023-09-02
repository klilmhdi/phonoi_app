import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:phonoi_app/core/utils/routes/routes.dart';
import 'package:phonoi_app/features/01-auth/presentation/bloc-cubit/signup/signup_cubit.dart';
import 'package:phonoi_app/features/02-home/0-layout/manage/app_layout/app_layout_cubit.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';
import 'package:phonoi_app/features/02-home/1-home_webview/manage/add_link/add_link_cubit.dart';
import 'package:phonoi_app/features/02-home/1-home_webview/manage/add_link/add_link_cubit.dart';
import 'package:phonoi_app/features/02-home/settings/manage/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc_observer.dart';
import 'core/shared_preferenced/shared_preferenced.dart';
import 'core/utils/notification/download_notification.dart';
import 'features/01-auth/presentation/bloc-cubit/login/login_cubit.dart';
import 'features/02-home/1-home_webview/manage/home/home_cubit.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  /// init firebase
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseAnalytics.instance;
  // await FirebaseNotification().initNotification();
  FacebookAuth.instance;

  /// init shared preferenced
  SharedPrefController().initPreferences();
  SharedPreferences.getInstance();

  /// init bloc observer
  Bloc.observer = MyBlocObserver();

  /// splash screen here
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();

  /// important windows manager implementation
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_LAYOUT_IN_SCREEN);
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON);

  /// run app here
  runApp(MyApp(
    widget: Layout(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.widget});

  Widget widget;

  @override
  Widget build(BuildContext context) {
    // S.(context).hi
    String deviceLanguage = PlatformDispatcher.instance.locale.languageCode;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            // Authentications
            BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
            BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
            // In app screens
            BlocProvider<AppLayoutCubit>(create: (context) => AppLayoutCubit()),
            BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
            BlocProvider<AddLinkCubit>(create: (context) => AddLinkCubit()),

            BlocProvider<SettingsCubit>(
                create: (context) => SettingsCubit()
                  ..logout(context)
                  ..fetchUserInfo()),
          ],
          child: GetMaterialApp(
            title: "Phonoi",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
              fontFamily: 'ElMessiri',
            ),
            // translations: Translation(),
            // fallbackLocale: const Locale('en'),
            // initialRoute: '/launch_screen',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routes: routes,
            locale: Locale("ar"),
            // locale: Locale(deviceLanguage),
            home: Layout(),
          ),
        );
      },
    );
  }
}
