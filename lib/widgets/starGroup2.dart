import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/countProvider.dart';
import './star.dart';

class StarGroup2 extends StatefulWidget {
  @override
  _StarGroup2State createState() => _StarGroup2State();
}

class _StarGroup2State extends State<StarGroup2>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  static Tween<double> _tween = Tween(begin: 0, end: 1);

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controller.reset();
    super.didChangeDependencies();
  }

  List<Widget> starGen(BuildContext context, int cnt) {
    int _count = cnt;
    int _maxWidth = MediaQuery.of(context).size.width.toInt();
    int _maxHeight = (MediaQuery.of(context).size.height * .68).toInt();

    if (cnt > 85) _count = 85;

    int stcount = _count ~/ 2;

    List<Widget> starGroup = List<Widget>.generate((1 + stcount), (i) {
      double rndWidth = Random().nextInt(_maxWidth).toDouble();
      double rndHeight = Random().nextInt(_maxHeight).toDouble();
      return Positioned(
        left: rndWidth,
        top: rndHeight,
        child: FadeTransition(
          opacity: _tween.animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval((Random().nextDouble() * 0.7), 1,
                  curve: Curves.fastLinearToSlowEaseIn),
            ),
          ),
          child: Star(),
        ),
      );
    });
    return starGroup;
  }

  @override
  Widget build(BuildContext context) {
    int _cont = Provider.of<CountProvider>(context, listen: false).count;
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {});
      }
    });
    return Stack(
      children: starGen(context, _cont),
    );
  }
}
