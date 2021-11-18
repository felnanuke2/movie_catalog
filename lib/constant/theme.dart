import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant.dart';

class ConstantThemes {
  ConstantThemes._();
  static final BottomNavigationBarThemeData _bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: ConstantColors.primary,
    unselectedIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    selectedIconTheme: IconThemeData(
      color: Colors.white,
      size: 28,
    ),
    selectedLabelStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Colors.white,
  );

  static final theme = ThemeData(
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white60,
      ),
      fillColor: Colors.black87,
      filled: true,
      enabledBorder: _border,
      focusedBorder: _border,
    ),
    scaffoldBackgroundColor: ConstantColors.background,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    colorScheme: ConstantColors.colorScheme,
  );

  static final _border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white.withOpacity(
        0.1,
      ),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(
      50,
    ),
  );
}
