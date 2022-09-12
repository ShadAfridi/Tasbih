import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import '../providers/cityProvider.dart';

class City extends StatelessWidget {
  const City({Key key}) : super(key: key);
  final String _assetName = 'assets/animations/City.flr';
  @override
  Widget build(BuildContext context) {
    CityProvider _con = Provider.of<CityProvider>(context);
    String _animText = _con.anim;
    return AspectRatio(
      aspectRatio: 18 / 10,
      child: Container(
        child: FlareActor(_assetName,
            sizeFromArtboard: false, fit: BoxFit.fill, animation: _animText),
      ),
    );
  }
}
