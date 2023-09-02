import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

loadingAlert(context) => QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    title: 'جاري التحميل',
    text: "",
    animType: QuickAlertAnimType.slideInDown,
    headerBackgroundColor: Colors.deepPurple,
    titleColor: Colors.deepPurple,
);

successAlert(context) => QuickAlert.show(
  context: context,
  type: QuickAlertType.loading,
  title: 'جاري التحميل',
  text: "",
  animType: QuickAlertAnimType.slideInDown,
  headerBackgroundColor: Colors.deepPurple,
  titleColor: Colors.deepPurple,
);
