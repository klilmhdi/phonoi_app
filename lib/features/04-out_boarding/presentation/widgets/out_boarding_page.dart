import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutBoardingPage extends StatelessWidget {
  const OutBoardingPage({
    super.key,
    required this.text,
    required int pageIndex,
    required PageController pageController,
  })  : _pageIndex = pageIndex,
        _pageController = pageController;

  final int _pageIndex;
  final String text;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 25.w,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: IconButton(
              onPressed: _pageIndex > 0
                  ? () => _pageController.previousPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOutBack,
                      )
                  : null,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 155.w,
          height: 145.h,
          child: Image.asset(
            'assets/icons/preview.png',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19.sp,
              color: Colors.white,
            ),
            // textDirection: TextDirection.rtl,
          ),
        ),
        IconButton(
          onPressed: _pageIndex < 2
              ? () => _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOutBack)
              : null,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
