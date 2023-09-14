import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:phonoi_app/core/utils/widgets/dialoges.dart';
import 'package:phonoi_app/features/01-auth/presentation/bloc-cubit/login/login_cubit.dart';
import 'package:phonoi_app/features/01-auth/presentation/view/signup_screen.dart';
import 'package:phonoi_app/generated/assets.dart';

import '../../../../core/utils/fonts/el_messiri_text_style.dart';
import '../../../../core/utils/functions/functions.dart';
import '../../../../generated/l10n.dart';

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
              body: Column(
                children: [
                  Container(
                    height: 264.h,
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
                          onPressed: () => cancelLoginWarningAlert(context),
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: const Color(0xffFFFFFF),
                            size: 33.sp,
                          ),
                        ),
                        elmessiriText(S.of(context).log_in_title,
                            fontWeight: FontWeight.bold, size: 20.sp, color: Colors.white),
                        SizedBox(height: 43.h),
                        GestureDetector(
                          onTap: () async => cubit.signInWithGoogle(context),
                          child: Container(
                            width: 280.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Logo(Logos.google, size: 22),
                                ),
                                // SizedBox(width: 30.w),
                                Text(
                                  S.of(context).log_in_google,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () async => cubit.signInWithFacebook(context),
                          child: Container(
                            width: 280.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Logo(Logos.facebook_logo, size: 22),
                                ),
                                // SizedBox(width: 30.w),
                                Text(
                                  S.of(context).log_in_facebook,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () async => cubit.signInWithTwitter(context),
                          child: Container(
                            width: 280.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Logo(Logos.twitter, size: 22),
                                ),
                                // SizedBox(width: 60.w),
                                Text(
                                  S.of(context).log_in_twitter,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                          Text(
                            S.of(context).log_in_email,
                            style: TextStyle(color: Colors.white, fontSize: 17),
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
