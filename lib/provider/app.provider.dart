import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _version = "v1.0.0";
  String get version => _version;

  void updateVersion(String value) {
    _version = value;
    notifyListeners();
  }

  Brightness _selectedBrightness = Brightness.light;
  Brightness get selectedBrightness => _selectedBrightness;
  // ThemeData _selectedTheme = ThemeData(
  //   primaryColor: Colors.red,
  //   brightness: Brightness.light,
  // );
  // ThemeData get selectedTheme => _selectedTheme;

  void toggleBrightness() {
    if (selectedBrightness == Brightness.light) {
      _selectedBrightness = Brightness.dark;
    } else {
      _selectedBrightness = Brightness.light;
    }
    notifyListeners();
  }

  bool _isMobileWeb = false;
  bool get isMobileWeb => _isMobileWeb;

  void updateMobileWeb(bool value) {
    _isMobileWeb = value;
    notifyListeners();
  }

  bool _isMobileApp = false;
  bool get isMobileApp => _isMobileApp;

  void updateMobileApp(bool value) {
    _isMobileApp = value;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updatedSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
