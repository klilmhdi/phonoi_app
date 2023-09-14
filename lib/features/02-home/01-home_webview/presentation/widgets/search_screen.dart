import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/features/02-home/01-home_webview/presentation/widgets/web_view.dart';

import '../../../../../generated/l10n.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  final String _selectedSearchEngine = 'https://www.google.com/search?q=';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onTap: () => {},
                  onSubmitted: (String query) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewPage(
                          url: _selectedSearchEngine + query,
                        ),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    // hintTextDirection: TextDirection.rtl,
                    constraints: BoxConstraints(
                      maxHeight: 48.h,
                      maxWidth: 360.w,
                    ),
                    fillColor: const Color(0xffEBEBEB),
                    filled: true,
                    hintText: S.of(context).search,
                    hintStyle: TextStyle(
                      color: const Color(0xff5D5D5D),
                      fontSize: 13.sp,
                    ),
                    prefixIcon: CircleAvatar(
                      backgroundColor: Colors.purple,
                        child: Center(
                            child: Icon(Icons.search, color: Colors.white, size: 24),
                    )),
                    suffixIcon: SizedBox(
                      width: 5.w,
                      height: 5.h,
                      child: Image.asset("assets/icons/google.png"),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
