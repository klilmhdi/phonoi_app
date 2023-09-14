import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';

import '../../../../generated/l10n.dart';
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120.h,
                width: 160.w,
                child: Image.asset('assets/app_icons/phonx.png'),
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
                      text: S.of(context).on_boarding_1,
                      pageIndex: _pageIndex,
                      pageController: _pageController,
                    ),
                    OutBoardingPage(
                      text: S.of(context).on_boarding_2,
                      pageIndex: _pageIndex,
                      pageController: _pageController,
                    ),
                    OutBoardingPage(
                      text: S.of(context).on_boarding_3,
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
              SizedBox(height: 28.h),
              SizedBox(
                height: 216.h,
                width: 216.w,
                child: Image.asset('assets/icons/tree.png'),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.w),
                child: SizedBox(
                  child: Text(
                    S.of(context).desc_on_boarding,
                    style: TextStyle(fontSize: 12.sp),
                    // textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () {
                  navAndFinish(context, Layout());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8C52FF),
                  minimumSize: Size(96.w, 38.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  S.of(context).start,
                  style: TextStyle(fontSize: 17.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}