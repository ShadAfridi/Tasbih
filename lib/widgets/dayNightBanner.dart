import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/sunMoon.dart';
import '../helpers/utils.dart';

/// [Widget] for rendering the box container of the sun and moon.
class DayNightBanner extends StatelessWidget {
  /// Current selected hour
  final int hour;

  /// How much the Image is displaced from [left] based on the current hour
  final double displace;

  /// Image asset of the sun
  final Image sunAsset;

  /// Image asset of the moon
  final Image moonAsset;

  /// Initialize the container
  DayNightBanner({
    this.hour,
    this.displace = 0,
    this.sunAsset,
    this.moonAsset,
  });

  /// Get the background color of the container, representing the time of day

  @override
  Widget build(BuildContext context) {
    final isDay = hour >= 6 && hour <= 18;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      height: 150,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth.round() - SUN_MOON_WIDTH;
          final top = sin(pi * displace) * 1.8;
          final left = (maxWidth * displace);
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.ease,
                child: SunMoon(
                  isSun: isDay,
                  sunAsset: sunAsset,
                  moonAsset: moonAsset,
                ),
                bottom: top * 20,
                left: left,
                duration: Duration(milliseconds: 500),
              ),
            ],
          );
        },
      ),
    );
  }
}
