
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._();
  static SharedPreferences? preferences;

  /*-----  -----*/

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static PrefService get instance {
    return PrefService._();
  }

  Future clearPrefs() async {
    await preferences?.clear();
  }

  Future<void> saveString({required String key, required String value}) async {
    await preferences?.setString(key, value);
  }

  String? getString({required String key}) {
    return preferences?.getString(key);
  }

  Future<void> saveBool({required String key, required bool value}) async {
    await preferences?.setBool(key, value);
  }

  bool getBool({required String key}) {
    return preferences?.getBool(key) ?? false;
  }


  Future<void> saveInt({required String key, required int value}) async {
    await preferences?.setInt(key, value);
  }

  int getInt({required String key}) {
    return preferences?.getInt(key) ?? 0;
  }

}
