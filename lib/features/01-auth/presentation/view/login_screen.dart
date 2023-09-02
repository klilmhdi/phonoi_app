import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phonoi_app/core/utils/widgets/snackbars_widgets.dart';
import 'package:phonoi_app/features/01-auth/controller/auth_controller.dart';
import 'package:phonoi_app/features/01-auth/presentation/bloc-cubit/login/login_cubit.dart';
import 'package:phonoi_app/features/01-auth/presentation/view/signup_screen.dart';
import 'package:phonoi_app/features/01-auth/presentation/widgets/custom_login_botton_widget.dart';
import 'package:phonoi_app/generated/assets.dart';

import '../../../../core/utils/fonts/el_messiri_text_style.dart';
import '../../../../core/utils/functions/functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final LoginCubit cubit = LoginCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black, size: 30.sp),
              ),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Container(
                    height: 264.h,
                    // width: 264.w,
                    width: double.infinity,
                    child: Image.asset(Assets.appIconsAppIcon),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xff8C52FF),
                    ),
                    height: 310.h,
                    width: 340.w,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // AwesomeDialog(
                            //     context: context,
                            //     animType: AnimType.topSlide,
                            //     dialogType: DialogType.question,
                            //     title: 'هل تريد تخطي عملية تسجيل الدخول؟',
                            //     titleTextStyle: elmessiriTextStyle(fontWeight: FontWeight.bold, size: 16),
                            //     btnOk: ElevatedButton(
                            //         style: ButtonStyle(
                            //             backgroundColor: MaterialStatePropertyAll(Colors.green),
                            //             animationDuration: Duration(seconds: 2)),
                            //         onPressed: () => Navigator.pushReplacementNamed(context, '/out_boarding_screen'),
                            //         child: elmessiriText('موافق',
                            //             fontWeight: FontWeight.w600, size: 13, color: Colors.white)))
                            //   ..show();
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: const Color(0xffFFFFFF),
                            size: 33.sp,
                          ),
                        ),
                        elmessiriText(" Phonoi تسجيل الدخول الى متصفح",
                            fontWeight: FontWeight.bold, size: 20.sp, color: Colors.white),
                        SizedBox(height: 43.h),
                        // loginButtonWidget('الإستمرار مع قوقل', FontAwesomeIcons.google, Colors.redAccent,
                        //     onTap: () => print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%clicked!!!")),
                        GestureDetector(
                          onTap: () async => cubit.signInWithGoogle(context),
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
                                  child: Icon(FontAwesomeIcons.google, size: 24, color: Colors.red),
                                ),
                                SizedBox(width: 60.w),
                                Text(
                                  "الإستمرار مع قوقل",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        loginButtonWidget('الإستمرار مع فيسبوك', FontAwesomeIcons.facebook, Colors.lightBlue,
                            onTap: () async => await AuthController.signUpWithFacebook().then((value) {
                                  Navigator.pushReplacementNamed(context, '/out_boarding_screen');
                                }).catchError((onError) => showSnackBar(onError.toString(), 3, context))),
                        SizedBox(height: 20.h),
                        loginButtonWidget('الإستمرار مع تويتر', FontAwesomeIcons.x, Colors.black87,
                            onTap: () async => await AuthController.signUpWithTwitter().then((value) {
                                  Navigator.pushReplacementNamed(context, '/out_boarding_screen');
                                }).catchError((onError) => showSnackBar(onError.toString(), 3, context))),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => navTo(context, SignupPage()),
                    child: Container(
                      width: 340.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0xff8C52FF),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Icon(Icons.email, color: Colors.white),
                          ),
                          // SizedBox(width: 10.w),
                          const Text(
                            'تسجيل الدخول باستخدام البريد الإلكتروني',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
