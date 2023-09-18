import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme() => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'ElMessiri',
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      )),
    );

ThemeData lightTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'ElMessiri',
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFF4F8F6),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white)));
