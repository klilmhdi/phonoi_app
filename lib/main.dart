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
import 'package:phonoi_app/core/app-cubit/themes/theme_cubit.dart';
import 'package:phonoi_app/core/firebase_services/firebase_services.dart';
import 'package:phonoi_app/core/style/app_style.dart';
import 'package:phonoi_app/core/utils/routes/routes.dart';
import 'package:phonoi_app/core/utils/themes/themes.dart';
import 'package:phonoi_app/features/01-auth/presentation/bloc-cubit/signup/signup_cubit.dart';
import 'package:phonoi_app/features/02-home/0-layout/manage/app_layout/app_layout_cubit.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';
import 'package:phonoi_app/features/02-home/4-settings/manage/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app-cubit/app_cubit/app_cubit/app_cubit.dart';
import 'core/app-cubit/language/language_cubit.dart';
import 'core/bloc_observer.dart';
import 'core/shared_preferenced/shared_preferenced.dart';
import 'features/01-auth/presentation/bloc-cubit/login/login_cubit.dart';
import 'features/02-home/01-home_webview/presentation/manage/add_link/add_link_cubit.dart';
import 'features/02-home/01-home_webview/presentation/manage/home/home_cubit.dart';
import 'features/02-home/01-home_webview/presentation/manage/new_link_cubit/new_link_cubit.dart';
import 'features/02-home/2-games_suggestions/presentation/manage/explorer_cubit.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  /// init firebase
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// init firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseAnalytics.instance;
  await FirebaseService().initFcmToken();
  FacebookAuth.instance;

  /// init shared preferenced
  SharedPrefController().initPreferences();
  SharedPreferences.getInstance();

  /// init bloc observer
  Bloc.observer = MyBlocObserver();
  HomeCubit();
  AddLinkCubit();
  NewLinkCubit()..init();

  /// splash screen here
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();

  /// important windows manager implementation
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_LAYOUT_IN_SCREEN);
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON);

  /// run app here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              // Authentications
              BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
              BlocProvider<AppCubit>(create: (context) => AppCubit()..setLanguage(languageCode: null)),
              BlocProvider<SignupCubit>(create: (context) => SignupCubit()),
              // In app screens
              BlocProvider<AppLayoutCubit>(create: (context) => AppLayoutCubit()),
              BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
              BlocProvider<ExplorerCubit>(create: (context) => ExplorerCubit()..fetchGames()),
              BlocProvider<AddLinkCubit>(create: (context) => AddLinkCubit()),
              BlocProvider<NewLinkCubit>(create: (context) => NewLinkCubit()..init()),
              BlocProvider<SettingsCubit>(
                  create: (context) => SettingsCubit()
                    ..logout(context)
                    ..fetchUserInfo()),
              // app service
              BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()..switchTheme()),
              BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()..switchLanguage()),
            ],
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                /// variables
                return BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return MaterialApp(
                      title: "Phonoi App",
                      debugShowCheckedModeBanner: false,
                      theme: AppStyle(themeIndex: state.themeCurrentIndex).currentTheme,

                      /// change themes and language
                      themeMode: ThemeMode.light,

                      locale: Locale(state.languageCode),
                      localizationsDelegates: [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      routes: routes,
                      initialRoute: '/splash_screen',
                      home: Layout(),
                    );
                  },
                );
              },
            ),
          );
        },
      );
}
