import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeColumnWidgets extends StatelessWidget {
  const HomeColumnWidgets({
    super.key,
    required this.imagesName,
    required this.name,
    required this.onTap,
  });

  final String imagesName;
  final String name;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 29.h,
            start: 20.w,
          ),
          child: IconButton(
            onPressed: onTap,
            icon: SizedBox(
              width: 39.23.w,
              height: 39.23.h,
              child: Image.asset(
                'assets/icons/$imagesName.png',
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsetsDirectional.only(top: 7.h, start: 20.w),
            child: Text(
              name,
              style: const TextStyle(fontSize: 12),
            )),
      ],
    );
  }
}
