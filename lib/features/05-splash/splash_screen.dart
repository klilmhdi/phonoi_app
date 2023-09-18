import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    fadeAnimation = Tween<double>(begin: .2, end: 1).animate(_animationController!);
    _animationController?.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 4), () => Navigator.pushReplacementNamed(context, '/layout'));
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 39.w, end: 38.w, top: 246.h),
        child: Column(
          children: [
            FadeTransition(
              opacity: fadeAnimation!,
              child: SizedBox(
                height: 298.h,
                width: 298.w,
                child: Image.asset('assets/app_icons/phonx.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
