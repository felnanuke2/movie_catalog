import 'package:flutter/material.dart';
import 'package:movie_catalog/widget/login_button.dart';
import 'package:movie_catalog/widget/tmdb_logo.dart';
import 'package:movie_catalog/controller/user_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  Animation<double>? _animation;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    _animation = Tween<double>(begin: 45, end: 230).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.fastLinearToSlowEaseIn));
    if (!UserController.loginSession) _animationController!.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: Image.network(
            'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kn72J6BFcN71VYOl8sTVeo7x9ph.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black.withOpacity(0.85),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TmdbLogo(),
                  SizedBox(
                    height: 80,
                  ),
                  LoginButton(_animation, _animationController)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
