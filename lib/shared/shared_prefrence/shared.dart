import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;
  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({required String key, dynamic value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData(key) async => sharedPreferences.get(key);
}
