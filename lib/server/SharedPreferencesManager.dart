import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  getAuthToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('accessToken');
  }
   clearAuthToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('accessToken');
  }
  getCurrentUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('username');
  }
}