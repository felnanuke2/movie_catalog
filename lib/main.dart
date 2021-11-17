import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:movie_catalog/constant/theme.dart';
import 'package:movie_catalog/screen/splash_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie Catalog',
      theme: ConstantThemes.theme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
