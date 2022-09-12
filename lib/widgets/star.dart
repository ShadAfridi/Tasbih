import 'dart:math';
import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.star,
        size: 1 + Random().nextInt(4).toDouble(),
        color: Colors.white,
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.white60,
          blurRadius: 7.5,
          spreadRadius: 0.52,
        ),
      ]),
    );
  }
}
