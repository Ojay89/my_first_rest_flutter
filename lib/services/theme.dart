import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  //contructor
  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) async{
    _themeData = theme;

    notifyListeners();
  }
}