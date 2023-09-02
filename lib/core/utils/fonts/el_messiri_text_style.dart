import 'package:flutter/material.dart';

Text elmessiriText(String text, {required FontWeight fontWeight, required double size, Color? color}) => Text(
      text,
      textAlign: TextAlign.center,
      style: elmessiriTextStyle(fontWeight: fontWeight, size: size, color: color),
    );

TextStyle elmessiriTextStyle({required FontWeight fontWeight, required double size, Color? color}) =>
    TextStyle(fontFamily: 'ElMessiri', color: color ?? Colors.black87, fontWeight: fontWeight, fontSize: size);
