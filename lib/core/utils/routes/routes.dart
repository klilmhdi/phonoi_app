import 'package:flutter/widgets.dart';
import 'package:phonoi_app/features/02-home/1-home_webview/view/add_download_link_screen.dart';
import 'package:phonoi_app/features/04-out_boarding/presentation/widgets/out_boarding_page.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';
import 'package:phonoi_app/features/02-home/3-files/view/downloads_screen.dart';

import '../../../features/01-auth/presentation/view/login_screen.dart';
import '../../../features/02-home/1-home_webview/view/add_link_screen.dart';
import '../../../features/04-out_boarding/presentation/view/out_boarding_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  // '/launch_screen': (context) => const LaunchScreen(),
  // '/privacy_screen': (context) => const PrivacyScreen(),
  // '/hello_screen': (context) => const HelloScreen(),
  '/bn_screen': (context) => Layout(),
  '/login_screen': (context) => LoginScreen(),
  '/out_boarding_screen': (context) => const OutBoardingScreen(),
  '/downloads_screen': (context) => DownloadsScreen(),
  // '/search_screen': (context) => SearchScreen(),
  // '/permission_access_screen': (context) => PermissionAccessScreen(),
  // '/downloads_screen': (context) => DawnloadsScreen(),
  // '/add_downloads_url_screen': (context) => AddDownloadUrlScreen(),
  // '/recent_sites_screen': (context) => RecentSitesScreen(),
  // '/storage_screen': (context) => StorageScreen(),
  '/add_link_screen': (context) => AddUrlScreen(
        onDownloadCompleted: () {},
      ),
  '/add_download_link_screen': (context) => AddLinkDownloadedScreen(),
};
