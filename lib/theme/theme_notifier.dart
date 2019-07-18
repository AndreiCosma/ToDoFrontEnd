import 'package:flutter/material.dart';

class ThemeInfoNotifier with ChangeNotifier {
  ThemeData _theme = ThemeData.light();

  ThemeData get getTheme => _theme;

  bool _light = true;

  void changeTheme() {
    _light = !_light;
    _theme = _light ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}
