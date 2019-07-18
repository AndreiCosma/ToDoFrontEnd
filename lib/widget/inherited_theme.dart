import 'package:flutter/material.dart';

class InheritedTheme extends InheritedWidget {
  InheritedTheme({@required this.appThemeData, @required Widget child})
      : super(child: child);

  final CustomThemeData appThemeData;

  @override
  bool updateShouldNotify(InheritedTheme oldWidget) {
    print('Got here.');
    return true;
  }

  static InheritedTheme of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedTheme);
}

enum Themes {
  LIGHT,
  DARK,
}

class CustomThemeData {
  ThemeData selectedTheme;

  CustomThemeData(ThemeData appTheme) {
    this.selectedTheme = appTheme;
  }

  void setTheme(Themes theme) => theme == Themes.LIGHT
      ? selectedTheme = ThemeData.light()
      : selectedTheme = ThemeData.dark();
}
