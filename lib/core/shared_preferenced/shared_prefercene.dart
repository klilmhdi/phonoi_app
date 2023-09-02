import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late SharedPreferences? _sharedPreference;

  Future init() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }

  static dynamic getSharedPrefData({required String key}) => _sharedPreference!.get(key);

  static Future<dynamic> setSharedPrefData({required String key, dynamic value}) async {
    switch (value.runtimeType) {
      case String:
        {
          _sharedPreference!.setString(key, value);
          break;
        }
      case int:
        {
          _sharedPreference!.setInt(key, value);
          break;
        }
      case double:
        {
          _sharedPreference!.setDouble(key, value);
          break;
        }
      case bool:
        {
          _sharedPreference!.setBool(key, value);
          break;
        }
      default:
        {
          print("Invalid choice ${value.runtimeType.toString()}");
        }
        break;
    }
  }
}
