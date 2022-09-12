import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import '../providers/countProvider.dart';

class Counter extends StatelessWidget {
  const Counter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider _con = Provider.of<CountProvider>(context);

    int _num = _con.count;

    if (Theme.of(context).brightness == Brightness.light) {
      return NeuText(
        '$_num',
        style: TextStyle(
            color: Color(0xffbd64a4),
            fontSize: MediaQuery.of(context).size.height > 800 ? 85 : 72),
        depth: 28,
        parentColor: Color(0xffbd64a4),
        spread: 6.5,
      );
    } else {
      return Text(
        '$_num',
        style: TextStyle(
          color: Colors.white38,
          fontSize: MediaQuery.of(context).size.height > 800 ? 75 : 65,
        ),
      );
    }
  }
}
