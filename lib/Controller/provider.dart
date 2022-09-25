import 'package:flutter/material.dart';

class ProviderData extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  void setThemeMode(ThemeMode mode) {
    currentTheme = mode;
    notifyListeners();
  }
}
