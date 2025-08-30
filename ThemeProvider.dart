// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  get themeMode => null;

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isDarkMode = pref.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isDarkMode', _isDarkMode);
  }
}
