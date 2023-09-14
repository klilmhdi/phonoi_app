import 'package:flutter/material.dart';
import 'dart:math';

// navigate and finish pervious screen
navAndFinish(context, Widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) {
      return false;
    });

// just navigate for screen
navTo(context, Widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

String generateRandomNumber() {
  Random random = Random();
  int randomNumber = 0;
  for (int i = 0; i < 4; i++) {
    randomNumber = (randomNumber * 10) + random.nextInt(10);
  }
  return randomNumber.toString();
}
