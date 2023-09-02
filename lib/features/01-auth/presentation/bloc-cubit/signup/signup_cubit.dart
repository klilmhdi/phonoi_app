import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phonoi_app/features/01-auth/controller/auth_controller.dart';
import 'package:phonoi_app/features/02-home/0-layout/view/layout.dart';

import '../../../../../core/utils/functions/functions.dart';
import '../../../../../core/utils/widgets/snackbars_widgets.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // sign in with email
  Future<void> signupViaEmail({
    required String name,
    required String email,
    required String phone,
    required String pass,
    String? uid,
  }) async {
    emit(LoadingCreateUserState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass).then((value) {
        print("#####################################################Uid:" + value.user!.uid);
        User? user = FirebaseAuth.instance.currentUser;
        final uid = user!.uid;
        FirebaseFirestore.instance.collection("users").doc(uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'uid': uid,
          'videos': [],
          'createdAt': Timestamp.now(),
        });
        emit(SuccessCreateUserState());
      });
    } on FirebaseAuthException catch (error) {
      print(error.message.toString());
      errorSnackBar("هذا الإيميل مستخدم بالفعل!!!" + "${error.message.toString()}");
      emit(ErrorCreateUserState("###########################Error here when create user: " + error.toString()));
    } catch (e) {
      print(e.toString());
      errorSnackBar(e.toString());
      emit(ErrorCreateUserState("###########################Error here when create user: " + e.toString()));
    }
  }

  // sign in with google account

  // Future<void> _goolgeSignIn({required BuildContext context}) async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final googleAuth = await googleAccount.authentication;
  //     if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //       try {
  //         final authResults = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken,
  //           idToken: googleAuth.idToken,
  //         ));
  //         if (authResults.additionalUserInfo!.isNewUser) {
  //           FirebaseFirestore.instance.collection("users").doc(uid).set({
  //             'name': name,
  //             'email': email,
  //             'phone': phone,
  //             'uid': uid,
  //             'videos': [],
  //             'createdAt': Timestamp.now(),
  //           });
  //         }
  //         WidgetsBinding.instance.addPostFrameCallback((_) async {
  //           Navigator.pushReplacementNamed(context, RootScreen.routName);
  //         });
  //       } on FirebaseException catch (error) {
  //         WidgetsBinding.instance.addPostFrameCallback((_) async {
  //           await MyAppMethods.showErrorORWarningDialog(
  //             context: context,
  //             subtitle: "An error has been occured ${error.message}",
  //             fct: () {},
  //           );
  //         });
  //       } catch (error) {
  //         WidgetsBinding.instance.addPostFrameCallback((_) async {
  //           await MyAppMethods.showErrorORWarningDialog(
  //             context: context,
  //             subtitle: "An error has been occured $error",
  //             fct: () {},
  //           );
  //         });
  //       }
  //     }
  //   }
  // }

  // sign in with google account

  // Future<void> signInWithGoogle(context) async {
  //   emit(LoadingSignInWithGoogleState());
  //   try {
  //     AuthController.signUpWithGoogle().then((value) {
  //       if (value.credential!.accessToken != null && value.credential!.token != null) {
  //         if (value.additionalUserInfo!.isNewUser) {
  //           FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set({
  //             'name': value.user!.displayName,
  //             'email': value.user!.email,
  //             'phone': value.user!.phoneNumber,
  //             'uid': value.user!.uid,
  //             'videos': [],
  //             'createdAt': Timestamp.now(),
  //           });
  //           emit(SuccessSignInWithGoogleState());
  //         }
  //       }
  //     });
  //   } on FirebaseException catch (error) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       await showSnackBar("الحساب دا موجود قبل كدة ${error.message}", 3, context);
  //       emit(ErrorSignInWithGoogleState("####################${error.toString()}"));
  //     });
  //   } catch (e) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       await showSnackBar("في مشكلة ${e.toString()}", 3, context);
  //       emit(ErrorSignInWithGoogleState("%%%%%%%%%%%%%%%%%${e.toString()}"));
  //     });
  //   }
  // }
}
