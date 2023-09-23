import 'package:flutter/material.dart';
import 'dart:math';

// navigate and finish pervious screen
navAndFinish(context, Widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) {
      return false;
    });

// just navigate for screen
navTo(context, Widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

// random numbers
String generateRandomNumber() {
  Random random = Random();
  int randomNumber = 0;
  for (int i = 0; i < 4; i++) {
    randomNumber = (randomNumber * 10) + random.nextInt(10);
  }
  return randomNumber.toString();
}

// navigate with animation to open music
class ScaleTransitionForMusic extends PageRouteBuilder {
  final Widget page;

  ScaleTransitionForMusic(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn, parent: animation, reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: child,
            );
          },
        );
}

navToMusic(context, Widget) => Navigator.push(context, ScaleTransitionForMusic(Widget));

// animation for screens
class RTLScreenAnimation extends PageRouteBuilder {
  final Widget page;

  RTLScreenAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: Duration(milliseconds: 1000),
            reverseTransitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn, parent: animation, reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
                child: page,
              );
            });
}

navToWithRTLAnimation(context, Widget) => Navigator.push(context, RTLScreenAnimation(Widget));

class LTRScreenAnimation extends PageRouteBuilder {
  final Widget page;

  LTRScreenAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: Duration(milliseconds: 1000),
            reverseTransitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn, parent: animation, reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}

navToWithLTRAnimation(context, Widget) => Navigator.push(context, LTRScreenAnimation(Widget));

class FloatingActionButtonSizeNavigate extends PageRouteBuilder {
  final Widget page;

  FloatingActionButtonSizeNavigate(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(seconds: 1),
          reverseTransitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn, parent: animation, reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

navToForFloatingActionButton(context, Widget) => Navigator.push(context, FloatingActionButtonSizeNavigate(Widget));
