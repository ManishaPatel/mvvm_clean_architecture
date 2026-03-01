// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreference extends GetxController {
//   Future<bool> setString(String key, String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setString(key,value);
//     return prefs.setString(key, value);
//   }
//
//   Future<String> getString(String key, String defaultValue) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.reload();
//     String? val = prefs.getString(key);
//     return val ?? defaultValue;
//   }
//
//   Future<bool> setInt(String key, int value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setString(key,value);
//     return prefs.setInt(key, value);
//   }
//
//   Future<int> getInt(String key, int defaultValue) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.reload();
//     int? val = prefs.getInt(key);
//     return val ?? defaultValue;
//   }
//
//   Future<bool> setDouble(String key, double value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setDouble(key, value);
//   }
//
//   Future<double> getDouble(String key, double defaultValue) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     double? val = prefs.getDouble(key);
//     return val ?? defaultValue;
//   }
//
//   Future<bool> setBool(String key, bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setString(key,value);
//     return prefs.setBool(key, value);
//   }
//
//   Future<bool> getBool(String key, bool defaultvalue) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.reload();
//     bool? val = prefs.getBool(key);
//     return val ?? defaultvalue;
//   }
//
//   Future<bool> clearSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     try {
//       prefs.clear();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }
