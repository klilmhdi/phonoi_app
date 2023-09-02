import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loginButtonWidget(String title, IconData icon, Color iconColor, {required VoidCallback onTap}) =>
    GestureDetector(
      onTap: () => onTap,
      child: Container(
        width: 299.w,
        height: 36.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xffFFFFFF),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            SizedBox(width: 60.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
