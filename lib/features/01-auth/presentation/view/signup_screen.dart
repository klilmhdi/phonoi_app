import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';

import '../../../../core/utils/functions/functions.dart';
import '../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../../generated/l10n.dart';
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
            } else if (state is ErrorCreateUserState) {
              showErrorSnackBar(state.toString(), 4, context);
            }
          },
          builder: (context, state) {
            final signupCubit = SignupCubit.get(context);
            return Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.centerRight, colors: [
                Color(0xff8062D6),
                Color(0xff8C52FF),
              ])),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 80, bottom: 30, right: 20, left: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).sign_up,
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
                                      signupCubit.signupViaEmail(context,
                                          name: signupCubit.nameController.text.trim(),
                                          email: signupCubit.emailController.text.trim(),
                                          phone: signupCubit.phoneController.text.trim(),
                                          pass: signupCubit.passController.text.trim());
                                    },
                                    keyboardType: TextInputType.name,
                                    controller: signupCubit.nameController,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return S.of(context).input_validate;
                                      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                        return S.of(context).name_input_validate;
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(color: Colors.black87),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.black87),
                                      hintText: S.of(context).name,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  TextFormField(
                                    onFieldSubmitted: (value) {
                                      signupCubit.signupViaEmail(context,
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
                                        return S.of(context).input_validate;
                                      } else if (!regex.hasMatch(value)) {
                                        return S.of(context).email_input_validate;
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(color: Colors.black87),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: S.of(context).email,
                                      hintStyle: TextStyle(color: Colors.black87),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  IntlPhoneField(
                                    onSubmitted: (value) {
                                      signupCubit.signupViaEmail(context,
                                          name: signupCubit.nameController.text.trim(),
                                          email: signupCubit.emailController.text.trim(),
                                          phone: signupCubit.phoneController.text.trim(),
                                          pass: signupCubit.passController.text.trim());
                                    },
                                    controller: signupCubit.phoneController,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(color: Colors.black87),
                                    validator: (value) {
                                      if (value == null || value.number.isEmpty) {
                                        return S.of(context).input_validate;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      iconColor: Colors.black87,
                                      hintStyle: TextStyle(color: Colors.black87),
                                      hintText: S.of(context).phone,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.grey,
                                  ),
                                  TextFormField(
                                    onFieldSubmitted: (value) {
                                      signupCubit.signupViaEmail(context,
                                          name: signupCubit.nameController.text.trim(),
                                          email: signupCubit.emailController.text.trim(),
                                          phone: signupCubit.phoneController.text.trim(),
                                          pass: signupCubit.passController.text.trim());
                                    },
                                    controller: signupCubit.passController,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return S.of(context).input_validate;
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
                                    style: TextStyle(color: Colors.black87),
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: S.of(context).password,
                                      hintStyle: TextStyle(color: Colors.black87),
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
                                    S.of(context).sign_up,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                            onPressed: () async {
                              if (signupCubit.formKey.currentState!.validate()) {
                                signupCubit.formKey.currentState!.save();
                                signupCubit
                                    .signupViaEmail(context,
                                        name: signupCubit.nameController.text.trim(),
                                        email: signupCubit.emailController.text.trim(),
                                        phone: signupCubit.phoneController.text.trim(),
                                        pass: signupCubit.passController.text.trim())
                                    .then((value) => navAndFinish(context, Layout()))
                                    .catchError((e) => e.toString());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
