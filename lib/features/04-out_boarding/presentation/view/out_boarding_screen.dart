import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';

import '../widgets/out_boarding_page.dart';

class OutBoardingScreen extends StatefulWidget {
  const OutBoardingScreen({super.key});

  @override
  State<OutBoardingScreen> createState() => _OutBoardingScreenState();
}

class _OutBoardingScreenState extends State<OutBoardingScreen> {
  int _pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 170.h,
              width: 170.w,
              child: Image.asset('assets/icons/logo.png'),
            ),
            Container(
              height: 149.h,
              width: 346.w,
              decoration: BoxDecoration(
                color: const Color(0xff8C52FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int value) {
                  setState(() {
                    _pageIndex = value;
                  });
                },
                children: [
                  OutBoardingPage(
                    text: "تحميل أي فيديو أو\n فيلم من أي مكان \n بكل سهولة",
                    pageIndex: _pageIndex,
                    pageController: _pageController,
                  ),
                  OutBoardingPage(
                    text: "تحميل المسلسلات \n والأفلام بجودة عالية",
                    pageIndex: _pageIndex,
                    pageController: _pageController,
                  ),
                  OutBoardingPage(
                    text: "تحميل من جميع \n مواقع التواصل \n الأجتماعي",
                    pageIndex: _pageIndex,
                    pageController: _pageController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabPageSelectorIndicator(
                  backgroundColor: _pageIndex == 0 ? const Color(0xff7B3FF0) : const Color(0xffDCDCDC),
                  borderColor: Colors.transparent,
                  size: 10.sp,
                ),
                SizedBox(width: 5.w),
                TabPageSelectorIndicator(
                  backgroundColor: _pageIndex == 1 ? const Color(0xff7B3FF0) : const Color(0xffDCDCDC),
                  borderColor: Colors.transparent,
                  size: 10.sp,
                ),
                SizedBox(width: 5.w),
                TabPageSelectorIndicator(
                  backgroundColor: _pageIndex == 2 ? const Color(0xff7B3FF0) : const Color(0xffDCDCDC),
                  borderColor: Colors.transparent,
                  size: 10.sp,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 216.h,
              width: 216.w,
              child: Image.asset('assets/icons/tree.png'),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.w),
              child: SizedBox(
                // width: 286.w,
                child: Text(
                  "حمل أي فيديو أو أي فيلم من أي مكان على الانترنت \n        بضغطة زر واحدة وبدون اعلانات مزعجة",
                  style: TextStyle(fontSize: 14.sp),
                  // textDirection: TextDirection.rtl,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: 294.w,
              height: 112.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff7B3FF0),
                  width: 1.w,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 28.w,
                  end: 28.w,
                  top: 11.h,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 237.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffDCDCDC),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Center(
                        child: Text(
                          "تجربة مجانية لمدة 30 يوم \n          ثم 1\$ كل شهر ",
                          style: TextStyle(fontSize: 13.sp),
                          // textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navAndFinish(context, Layout());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8C52FF),
                        minimumSize: Size(102.w, 28.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "ابدأ",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//"تحميل المسلسلات \n والأفلام بجودة عالية"

//"تحميل من جميع \n مواقع التواصل \n الأجتماعي"
