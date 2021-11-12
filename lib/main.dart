import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/screen/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
              enabledBorder: border,
              focusedBorder: border),
          primarySwatch: MaterialColor(Colors.white.value, {
            50: Colors.white,
            100: Colors.white12,
            200: Colors.white24,
            300: Colors.white30,
            400: Colors.white38,
            500: Colors.white54,
            600: Colors.white60,
            700: Colors.white70,
            800: Colors.white70,
            900: Colors.white70,
          })),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

  final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
      borderRadius: BorderRadius.circular(50));
}
