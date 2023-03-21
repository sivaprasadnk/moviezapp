import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
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
