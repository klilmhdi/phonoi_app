import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';

import '../../../../core/utils/functions/functions.dart';
import '../../../../core/utils/widgets/snackbars_widgets.dart';
import '../bloc-cubit/signup/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => SignupCubit(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SuccessCreateUserState) {
              navAndFinish(context, Layout());
            } else if (state is ErrorCreateUserState) {
              errorSnackBar(state.toString());
            }
          },
          builder: (context, state) {
            final signupCubit = SignupCubit.get(context);
            return Container(
              // height: MediaQuery.of(context).size.height,
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.centerRight, colors: [
                // Color(0xff322653),
                Color(0xff8062D6),
                Color(0xff8C52FF),
              ])),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 80, bottom: 30, right: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 320,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                        offset: const Offset(0, 10))
                                  ]),
                              child: Form(
                                key: signupCubit.formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      onFieldSubmitted: (value) {
                                        signupCubit.signupViaEmail(
                                            name: signupCubit.nameController.text.trim(),
                                            email: signupCubit.emailController.text.trim(),
                                            phone: signupCubit.phoneController.text.trim(),
                                            pass: signupCubit.passController.text.trim());
                                      },
                                      keyboardType: TextInputType.name,
                                      controller: signupCubit.nameController,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'هذا الحقل فارغ , برجاء ملء هذا الحقل';
                                        } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                          return "الرجاء اكتب الإسم بشكل صحيح!!";
                                        } else {
                                          return null;
                                        }
                                        // if (value!.isNotEmpty) {
                                        //   if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                        //     return null;
                                        //   } else {
                                        //     return 'الرجاء كتابة اسمك بشكل صحيح!!' ;
                                        //   }
                                        // } else {
                                        //   return 'هذا الحقل فارغ , برجاء ملء هذا الحقل' ;
                                        // }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'الإسم بالكامل',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      onFieldSubmitted: (value) {
                                        signupCubit.signupViaEmail(
                                            name: signupCubit.nameController.text.trim(),
                                            email: signupCubit.emailController.text.trim(),
                                            phone: signupCubit.phoneController.text.trim(),
                                            pass: signupCubit.passController.text.trim());
                                      },
                                      controller: signupCubit.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String? value) {
                                        final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                        final regex = RegExp(pattern);
                                        if (value == null || value.isEmpty) {
                                          return 'هذا الحقل فارغ , برجاء ملء هذا الحقل';
                                        } else if (!regex.hasMatch(value)) {
                                          return "الرجاء اكتب البريد الإلكتروني بشكل صحيح!!";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'البريد الإلكتروني',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      onFieldSubmitted: (value) {
                                        signupCubit.signupViaEmail(
                                            name: signupCubit.nameController.text.trim(),
                                            email: signupCubit.emailController.text.trim(),
                                            phone: signupCubit.phoneController.text.trim(),
                                            pass: signupCubit.passController.text.trim());
                                      },
                                      controller: signupCubit.phoneController,
                                      keyboardType: TextInputType.phone,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'هذا الحقل فارغ , برجاء ملء هذا الحقل';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'رقم الهاتف',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                    Divider(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      onFieldSubmitted: (value) {
                                        signupCubit.signupViaEmail(
                                            name: signupCubit.nameController.text.trim(),
                                            email: signupCubit.emailController.text.trim(),
                                            phone: signupCubit.phoneController.text.trim(),
                                            pass: signupCubit.passController.text.trim());
                                      },
                                      controller: signupCubit.passController,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'هذا الحقل فارغ , برجاء ملء هذا الحقل';
                                        } else if (value.length >= 8) {
                                          if (RegExp(r'[A-Z]').hasMatch(value)) {
                                            // Check if the value contains at least one lowercase letter
                                            if (RegExp(r'[a-z]').hasMatch(value)) {
                                              // Check if the value contains at least one digit
                                              if (RegExp(r'\d').hasMatch(value)) {
                                                // Check if the value contains at least one symbol
                                                if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'يجب أن تحتوي كلمة المرور على رمز واحد على الأقل';
                                                }
                                              } else {
                                                return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
                                              }
                                            } else {
                                              return 'يجب أن تحتوي كلمة المرور على حرف قصير على الأقل';
                                            }
                                          } else {
                                            return 'يجب أن تحتوي كلمة المرور على حرف كبير على الأقل';
                                          }
                                        } else {
                                          return 'يجب أن تكون كلمة المرور أكبر من أو تساوي 8 أحرف';
                                        }
                                      },
                                      obscureText: true,
                                      keyboardType: TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'كلمة المرور',
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 80),
                            MaterialButton(
                              shape: const StadiumBorder(),
                              minWidth: 230,
                              height: 45,
                              color: const Color(0xff616161),
                              child: state is LoadingCreateUserState
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                              onPressed: () async {
                                if (signupCubit.formKey.currentState!.validate()) {
                                  signupCubit.formKey.currentState!.save();
                                  signupCubit
                                      .signupViaEmail(
                                          name: signupCubit.nameController.text.trim(),
                                          email: signupCubit.emailController.text.trim(),
                                          phone: signupCubit.phoneController.text.trim(),
                                          pass: signupCubit.passController.text.trim())
                                      .then((value) => navAndFinish(context, Layout()))
                                      .catchError((e) => e.toString());
                                }
                              },
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 77,
                                ),
                                Row(children: [
                                  SizedBox(
                                    width: 55.0,
                                  ),
                                  Expanded(child: Divider(color: Colors.black87)),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Text(
                                    "أو تسجيل الدخول عبر",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Expanded(child: Divider(color: Colors.black87)),
                                  SizedBox(
                                    width: 55.0,
                                  ),
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.facebook, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: const Color(0xffe15241),
                                    child: Icon(Icons.g_mobiledata_outlined, color: Colors.white),
                                  ),
                                )
                              ],
                            )
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
      ),
    );
  }
}
