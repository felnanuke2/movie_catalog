import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/controller/user_controller.dart';

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
