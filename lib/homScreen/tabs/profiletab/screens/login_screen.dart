import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/globalWidget/tmdb_logo.dart';
import 'package:movie_catalog/user/user_controller.dart';

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

class LoginButton extends StatelessWidget {
  AnimationController? animationController;
  Animation<double>? animation;
  LoginButton(this.animation, this.animationController);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        if (animation!.value <= 45)
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(BACKGROUND_COLOR),
                ),
              ),
              TextButton(
                  onPressed: () {
                    UserController.cancelLogin = true;

                    animationController!.forward();
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ))
            ],
          );
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 45,
                width: animation!.value,
                child: ElevatedButton(
                    onPressed: () {
                      animationController!.reverse();
                      UserController.cancelLogin = false;
                      UserController.createSession();
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            if (animation!.value < 229)
              TextButton(
                  onPressed: () {
                    animationController!.forward();
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Colors.red.withOpacity(45 / animation!.value), fontSize: 16),
                  ))
          ],
        );
      },
    );
  }
}
