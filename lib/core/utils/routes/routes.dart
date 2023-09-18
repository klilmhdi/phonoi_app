import 'package:flutter/widgets.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';
import 'package:phonoi_app/features/02-home/01-home_webview/presentation/view/home_screen.dart';
import 'package:phonoi_app/features/02-home/3-files/view/downloads_screen.dart';
import 'package:phonoi_app/features/05-splash/splash_screen.dart';

import '../../../features/01-auth/presentation/view/login_screen.dart';
import '../../../features/02-home/01-home_webview/presentation/view/add_download_link_screen.dart';
import '../../../features/04-out_boarding/presentation/view/out_boarding_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splash_screen': (context) => const SplashScreen(),
  '/login_screen': (context) => LoginScreen(),
  '/layout': (context) => Layout(),
  '/out_boarding_screen': (context) => const OutBoardingScreen(),
  '/home_screen': (context) => HomeScreen(),
  '/downloads_screen': (context) => DownloadsScreen(),
  '/add_download_link_screen': (context) => AddLinkDownloadedScreen(),
};
