import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/functions/functions.dart';
import '../../../../core/utils/functions/functions.dart';
import '../../../01-auth/models/user_model.dart';
import '../../../01-auth/presentation/view/login_screen.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context, listen: false);

  Future<void> logout(context) async {
    emit(LogoutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) => navAndFinish(context, LoginScreen()));
    emit(LogoutSuccessState());
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;

  Future<UserModel?> fetchUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    emit(LoadingFetchingDataState());
    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userDocDict = userDoc.data();
      userModel = UserModel(
        uid: userDoc.get("uid") ?? "123123123123",
        name: userDoc.get("name") ?? "Hello",
        email: userDoc.get('email') ?? "hello@gmail.com",
        phone: userDoc.get('phone') ?? "34092835934",
        videos: userDocDict!.containsKey("videos") ? userDoc.get("videos") : [],
        createdAt: userDoc.get('createdAt') ?? Timestamp.now(),
      );
      emit(SuccessFetchingDataState(userModel!));
      return userModel;
    } on FirebaseException catch (error) {
      emit(ErrorFetchingDataState("###############Exception" + error.message.toString()));
      throw error.message.toString();
    } catch (error) {
      emit(ErrorFetchingDataState("###############Error" + error.toString()));
      rethrow;
    }
  }

  @override
  Future<void> close() {
    fetchUserInfo();
    return super.close();
  }
}
