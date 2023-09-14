import 'package:flutter/material.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';
import 'package:phonoi_app/features/01-auth/presentation/view/pass_verify_screen.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../features/01-auth/presentation/view/email_verify_screen.dart';
import '../../../generated/l10n.dart';

loadingAlert(context) => QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'جاري التحميل',
      text: "",
      animType: QuickAlertAnimType.slideInDown,
    );

// successAlert(context) => QuickAlert.show(
//       context: context,
//       type: QuickAlertType.loading,
//       title: 'جاري التحميل',
//       text: "",
//       animType: QuickAlertAnimType.slideInDown,
//     );

cancelLoginWarningAlert(context) => QuickAlert.show(
    context: context,
    type: QuickAlertType.warning,
    title: S.of(context).cancel_login,
    text: "",
    animType: QuickAlertAnimType.slideInDown,
    showCancelBtn: true,
    showConfirmBtn: true,
    confirmBtnColor: Colors.blueGrey,
    cancelBtnText: S.of(context).cancel,
    confirmBtnText: S.of(context).ok,
    confirmBtnTextStyle: TextStyle(color: Colors.white),
    cancelBtnTextStyle: TextStyle(),
    onCancelBtnTap: () => Navigator.pop(context),
    onConfirmBtnTap: () => Navigator.pushReplacementNamed(context, '/out_boarding_screen'));

cancelLogoutWarningAlert(context, confirmFunction) => QuickAlert.show(
    context: context,
    type: QuickAlertType.warning,
    title: S.of(context).cancel_logout,
    text: "",
    animType: QuickAlertAnimType.slideInDown,
    showCancelBtn: true,
    showConfirmBtn: true,
    confirmBtnColor: Colors.blueGrey,
    cancelBtnText: S.of(context).cancel,
    confirmBtnText: S.of(context).ok,
    confirmBtnTextStyle: TextStyle(color: Colors.white),
    cancelBtnTextStyle: TextStyle(),
    onCancelBtnTap: () => Navigator.pop(context),
    onConfirmBtnTap: () => confirmFunction());

verifyMethodAlert(context, confirmFunction) => QuickAlert.show(
    context: context,
    type: QuickAlertType.info,
    title: S.of(context).select_verity_method_title,
    text: S.of(context).select_verity_method,
    animType: QuickAlertAnimType.slideInDown,
    showCancelBtn: true,
    showConfirmBtn: true,
    confirmBtnColor: Colors.blueGrey,
    cancelBtnText: S.of(context).using_email,
    confirmBtnText: S.of(context).using_phone,
    confirmBtnTextStyle: TextStyle(color: Colors.white),
    cancelBtnTextStyle: TextStyle(color: Colors.white),
    onCancelBtnTap: () => navTo(context, EmailVerifyScreen()),
    onConfirmBtnTap: () => navTo(context, PhoneVerifyScreen()));
