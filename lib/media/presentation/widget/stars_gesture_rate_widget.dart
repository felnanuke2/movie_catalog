import 'dart:async';

import 'package:flutter/material.dart';

class StarsGestureRateWidget extends StatelessWidget {
  num? starCount;
  StarsGestureRateWidget(this.starCount);
  var _starController = StreamController<num>.broadcast();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.black.withOpacity(0.01),
      content: Row(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              var position = details.localPosition.dx;
              if (position > 100) position = 100;
              if (position < 5) position = 5;
              starCount = position / 10;
              var string = starCount!.toStringAsFixed(2);

              if (string.contains('.')) {
                var splited = string.split('.');
                var first = splited.first;
                var last = splited.last;
                var value = num.parse(last);
                var rest = 0;
                if (value > 50 && value < 70) value = 50;
                if (value < 50 && value > 30) value = 50;
                if (value < 30) {
                  value = 0;
                }
                if (value > 70) {
                  value = 0;
                  rest += 1;
                }

                starCount = int.parse(first) + rest + (value / 100);
              }
              _starController.add(starCount!);
            },
            onHorizontalDragEnd: (details) {
              Navigator.pop(context, starCount);
            },
            child: StreamBuilder<num>(
                stream: _starController.stream,
                initialData: starCount,
                builder: (context, snapshot) {
                  var white = 10 - snapshot.data!.round();
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                              colors: List.generate(snapshot.data!.round(),
                                      (index) => Color(Colors.amber.value)) +
                                  List.generate(white, (index) => Colors.white))
                          .createShader(bounds);
                    },
                    child: Row(
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 30,
                              )),
                    ),
                  );
                }),
          ),
          SizedBox(
            width: 8,
          ),
          StreamBuilder<num>(
              stream: _starController.stream,
              initialData: starCount,
              builder: (context, snapshot) {
                return Text(
                  '${starCount!.toStringAsFixed(1)} / 10.0',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              })
        ],
      ),
    );
  }
}
