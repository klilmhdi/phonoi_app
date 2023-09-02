import 'package:phonoi_app/features/01-auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserPrKeys {
  loggedIn,
  password,
  id,
  token,
  name,
  deviceType,
  fcmToken,
  status,
  phone,
  email
}

class SharedPrefController {
  SharedPrefController._();

  static SharedPrefController? _instance;

  late SharedPreferences? _sharedPreferences;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  T? getValueFor<T>(String key) {
    if (_sharedPreferences!.containsKey(key)) {
      return _sharedPreferences!.get(key) as T;
    }
    return null;
  }

  Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return await _sharedPreferences!.setString(key, value);
  }

  Future<void> saveUser({required UserModel user}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(UserPrKeys.loggedIn.name, true);
    // await prefs.setInt(UserPrKeys.id.name, user.id);
    await prefs.setString(UserPrKeys.name.name, user.name ?? "");
    await prefs.setString(UserPrKeys.email.name, user.email ?? "");
    // await prefs.setString(UserPrKeys.deviceType.name, user.devicetype ?? "");
    // await prefs.setString(UserPrKeys.fcmToken.name, user.fcmtoken ?? "");
    // await prefs.setString(UserPrKeys.status.name, user.status.name);
    // await prefs.setString(UserPrKeys.lat.name, user.lat ?? '');
    // await prefs.setString(UserPrKeys.long.name, user.long ?? '');
    // await prefs.setString(UserPrKeys.token.name, "Bearer ${user.token}");
    // await prefs.setString(UserPrKeys.firstName.name, user.token);
  }

  Future<void> saveUserLocally(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    print('Value saved locally: $value');
  }

  Future<String?> getSavedValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    print('Retrieved value: $value');
    return value;
  }

  void clear() async {
    _sharedPreferences!.clear();
  }
}
