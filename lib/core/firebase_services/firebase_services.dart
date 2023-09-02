import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  late final firebaseMessaging = FirebaseMessaging.instance;

  // init fcm token
  Future<void> initFcmToken() async {
    final fcmToken = await firebaseMessaging.getToken();
    print("Token: $fcmToken");
  }
}
