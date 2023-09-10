import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showBottomSheetDialog(context) {
  Get.defaultDialog(
    title: 'قم بتسجيل الدخول الى متصفح phonoi',
    titleStyle: TextStyle(fontSize: 20),
    titlePadding: EdgeInsetsDirectional.only(top: 16, bottom: 19),
    contentPadding: EdgeInsetsDirectional.only(start: 30, end: 30, bottom: 19),
    backgroundColor: Colors.white,
    content: Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'قم بتسجيل الدخول لمزامنة بياناتك والحصول على المزيد \nمن الميزات',
          style: TextStyle(fontSize: 12, color: Color(0xff343434)),
        ),
        SizedBox(height: 18),
        GestureDetector(
          // onTap: () =>
          child: Container(
            width: 299,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xffDFDFDF),
            ),
            child: Row(
              // textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset("assets/icons/google.png"),
                ),
                SizedBox(width: 45),
                const Text(
                  'الاستمرار مع جوجل',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          // onTap: () =>
          child: Container(
            width: 299,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xffDFDFDF),
            ),
            child: Row(
              // textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset("assets/icons/facebook.png"),
                ),
                SizedBox(width: 45),
                const Text(
                  'الاستمرار مع فيسبوك',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          // onTap: () =>
          child: Container(
            width: 299,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xffDFDFDF),
            ),
            child: Row(
              // textDirection: TextDirection.rtl,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset("assets/icons/twitter.png"),
                ),
                SizedBox(width: 45),
                const Text(
                  'الاستمرار مع تويتر',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
