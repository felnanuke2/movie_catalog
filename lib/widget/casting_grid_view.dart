import 'package:flutter/material.dart';
import 'package:movie_catalog/core/model/credit_model.dart';
import 'package:movie_catalog/widget/cast_avatar_item.dart';

class CastingGridView extends StatelessWidget {
  Stream<CreditModel>? _stream;
  CreditModel? _initialData;
  CastingGridView(this._initialData, this._stream);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CreditModel>(
        stream: _stream,
        initialData: _initialData,
        builder: (context, snapshotActors) {
          if (snapshotActors.data == null) return Container();
          var actorsList = snapshotActors.data!.cast!;
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
                    actorsList.length >= 10 ? 10 : actorsList.length,
                    (index) =>
                        Container(child: CastAvatarItem(actorsList[index]))),
              ),
            ],
          );
        });
  }
}
