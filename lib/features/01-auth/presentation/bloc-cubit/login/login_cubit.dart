import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../controller/auth_controller.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context, listen: false);

  // sign in with google
  Future<void> signInWithGoogle(context) async {
    emit(LoadingSignInWithGoogleState());
    try {
      AuthController.signUpWithGoogle().then((value) {
        FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set({
          'name': value.user!.displayName,
          'email': value.user!.email,
          'phone': value.user!.phoneNumber,
          'uid': value.user!.uid,
          'videos': [],
          'createdAt': Timestamp.now(),
        });
        Navigator.pushReplacementNamed(context, '/out_boarding_screen');
        emit(SuccessSignInWithGoogleState());
      });
    } on FirebaseException catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showSnackBar("الحساب دا موجود قبل كدة ${error.message}", 3, context);
        emit(ErrorSignInWithGoogleState("####################${error.toString()}"));
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showSnackBar("في مشكلة ${e.toString()}", 3, context);
        emit(ErrorSignInWithGoogleState("%%%%%%%%%%%%%%%%%${e.toString()}"));
      });
    }
  }

  // sign in with facebook
  Future<void> signInWithFacebook(context) async {}

  // sign in with twitter
  Future<void> signInWithTwitter(context) async {}
}