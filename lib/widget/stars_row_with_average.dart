import 'package:flutter/material.dart';

class StarsRowWithAverage extends StatelessWidget {
  num? average;
  StarsRowWithAverage(this.average);

  @override
  Widget build(BuildContext context) {
    String _voteAvagare = (average! / 2).toString();
    int _voteRate = 0;
    int? _voteRateRest;
    if (_voteAvagare.toString().contains('.')) {
      var splitedAverage = _voteAvagare.split('.');
      _voteRate = int.parse(splitedAverage[0]);
      _voteRateRest = num.parse(splitedAverage[1]).round();
    } else {
      _voteRate = int.parse(_voteAvagare);
    }
    if (_voteRateRest != null) {
      _voteRate += 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: List.generate(
                    5, (index) => Icon(Icons.star_border_outlined, color: Colors.grey)),
              ),
              Row(
                children: List.generate(_voteRate, (index) {
                  if (_voteRateRest != null) {
                    if (index == _voteRate - 1)
                      return Icon(Icons.star_half_outlined, color: Colors.amber);
                  }
                  return Icon(Icons.star, color: Colors.amber);
                }),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          average!.toStringAsFixed(1),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}
