import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:movie_catalog/constant/constant.dart';

class ConstantThemes {
  ConstantThemes._();
  static final theme = ThemeData(
      primaryColor: BACKGROUND_COLOR,
      scaffoldBackgroundColor: BACKGROUND_COLOR,
      appBarTheme: AppBarTheme(color: BACKGROUND_COLOR),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white)),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white60),
          fillColor: Colors.black87,
          filled: true,
          enabledBorder: _border,
          focusedBorder: _border),
      primarySwatch: generateMaterialColor(color: Colors.white));

  static final _border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
      borderRadius: BorderRadius.circular(50));
}
