import 'package:flutter/material.dart';
import '../helpers/utils.dart';

/// [Widget] for rendering the Sun and Moon Asset
class SunMoon extends StatelessWidget {
  /// Whether currently the Sun is displayed
  final bool isSun;

  /// The Image asset for the sun
  final Image sunAsset;

  /// The Image asset for the moon
  final Image moonAsset;

  /// Initialize the Class
  SunMoon({
    this.isSun,
    this.sunAsset,
    this.moonAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SUN_MOON_WIDTH,
      child: AnimatedSwitcher(
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        duration: Duration(milliseconds: 250),
        child: isSun
            ? Container(
                key: ValueKey(1),
                child: sunAsset ??
                    Image(
                      image: AssetImage(
                        "assets/images/sun.png",
                      ),
                    ))
            : Container(
                key: ValueKey(2),
                child: moonAsset ??
                    Image(
                      image: AssetImage("assets/images/moon.png"),
                    ),
              ),
        transitionBuilder: (child, anim) {
          return ScaleTransition(
            scale: anim,
            child: FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: anim.drive(
                  Tween(
                    begin: Offset(0, 4),
                    end: Offset(0, 0),
                  ),
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
