import 'package:flutter/material.dart';
import 'package:movie_catalog/constant/constant_colors.dart';
import 'package:movie_catalog/model/credit_model.dart';

class CastAvatarItem extends StatelessWidget {
  Cast? _actorModel;
  CastAvatarItem(this._actorModel);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              child: _actorModel!.profilePath != null ? Container() : FlutterLogo(),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: _actorModel!.profilePath != null
                      ? DecorationImage(
                          image: NetworkImage(
                              'https://www.themoviedb.org/t/p/w200${_actorModel!.profilePath}'),
                          fit: BoxFit.cover)
                      : null)),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          _actorModel!.name!,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        Text(
          _actorModel!.character!,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10),
        )
      ],
    );
  }
}
