import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TmdbLogo extends StatelessWidget {
  const TmdbLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(colors: [
          // Color(0xff0d253f),
          Color(0xff01b4e4),
          Color(0xff90cea1),
        ]).createShader(bounds);
      },
      child: Column(
        children: [
          Center(
            child: Text(
              'Powered By',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          SvgPicture.asset(
            'assets/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg',
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
