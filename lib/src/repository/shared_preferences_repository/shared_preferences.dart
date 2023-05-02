import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository extends GetxController {
  static SharedPreferencesRepository get instance => Get.find();

  static late final _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setUserEmail(String email) async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setString('email', email);
  }

  static Future<void> setUserName(String user) async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setString('user', user);
  }

  static Future<void> setUserPassword(String password) async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setString('password', password);
  }

  static Future<void> setUserPhone(String phoneNo) async {
    final SharedPreferences prefs = await _sharedPreferences;
    prefs.setString('phone', phoneNo);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await _sharedPreferences;
    return prefs.getString('user');
  }
}
