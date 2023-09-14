import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonoi_app/core/utils/functions/functions.dart';

import '../../../../../core/utils/widgets/snackbars_widgets.dart';
import '../../../../../generated/l10n.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // sign in with email
  Future<void> signupViaEmail(
    context, {
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
      showErrorSnackBar("هذا الإيميل مستخدم بالفعل!!!" + "${error.message.toString()}", 4, context);
      emit(ErrorCreateUserState("###########################Error here when create user: " + error.toString()));
    } catch (e) {
      print(e.toString());
      showErrorSnackBar(e.toString(), 4, context);
      emit(ErrorCreateUserState("###########################Error here when create user: " + e.toString()));
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  String? phoneVerify;
  String? emailVerify;
  int timer = 60;

  // to verify email
  Future<void> verityEmail() async {}

  // to verify phone number
  Future<void> verityPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showErrorSnackBar(S.of(context).phone_verify_error, 4, context);
        }
      },
      codeSent: (String verificationId, int? resendToken) async => phoneVerify = verificationId,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void sendCode() async {
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = phoneCodeController.text;

    // ${generateRandomNumber().toString()}
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: phoneVerify!, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
