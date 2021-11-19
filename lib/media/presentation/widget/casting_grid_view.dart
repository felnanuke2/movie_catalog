import 'package:flutter/material.dart';

import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/widget/cast_avatar_item.dart';

class CastingGridView extends StatelessWidget {
  final CreditModel creditModel;
  const CastingGridView({
    Key? key,
    required this.creditModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Elenco',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GridView.count(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 3 / 4,
          crossAxisCount: 5,
          children: List.generate(
              (creditModel.cast?.length ?? 0) >= 10
                  ? 10
                  : creditModel.cast?.length ?? 0,
              (index) =>
                  Container(child: CastAvatarItem(creditModel.cast![index]))),
        ),
      ],
    );
  }
}
