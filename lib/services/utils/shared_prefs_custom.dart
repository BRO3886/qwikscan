import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> getUserEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final key = "email";
    return preferences.getString(key);
  }

  void setUserEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'email';
    prefs.setString(key, value);
    print("email stored");
  }

  Future<String> getUserID() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final key = "userid";
    return preferences.getString(key);
  }

  void setUserID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'userid';
    prefs.setString(key, value);
    print("userid stored");
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'name';
    return prefs.getString(key);
  }

  void setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'name';
    prefs.setString(key, value);
    print("name stored");
  }

  Future<bool> getLoggedInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'logged-in';
    return prefs.getBool(key);
  }

  void setLoggedInStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'logged-in';
    prefs.setBool(key, value);
    print("login status cached");
  }

  Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'token';
    return prefs.getString(key);
  }

  void setUserToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'token';
    prefs.setString(key, value);
    print("token cached");
  }
}
