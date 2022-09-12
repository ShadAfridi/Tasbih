import 'package:flutter/material.dart';

/// [Widget] for rendering the AM/PM button
class AmPm extends StatelessWidget {
  /// Currently selected by user
  final String selected;

  /// [onChange] handler for AM/PM
  final void Function(String) onChange;

  /// Accent color to be used for the button
  final Color accentColor;

  /// Accent color to be used for the unselected button
  final Color unselectedColor;

  /// Default [TextStyle]
  final _style = TextStyle(fontSize: 20);

  final Shader _selectedColor = LinearGradient(
    colors: <Color>[
      Color(0xffde7ac2),
      Colors.deepPurpleAccent,
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 1000.0, 70.0));

  final Shader _unselectedColor = LinearGradient(
    colors: <Color>[
      Colors.grey,
      Colors.grey,
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 1000.0, 70.0));

  /// Initialize the buttons
  AmPm({this.selected, this.onChange, this.accentColor, this.unselectedColor});

  @override
  Widget build(BuildContext context) {
    final isAm = selected == 'am';
    final unselectedOpacity = 0.5;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              splashColor: Theme.of(context).accentColor.withOpacity(0.2),
              highlightColor: Colors.deepPurpleAccent.withOpacity(0.2),
              onTap: !isAm
                  ? () {
                      onChange("am");
                    }
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Opacity(
                  opacity: !isAm ? unselectedOpacity : 1,
                  child: Text(
                    "am",
                    style: _style.copyWith(
                      fontWeight: isAm ? FontWeight.bold : null,
                      foreground: Paint()
                        ..shader = isAm ? _selectedColor : _unselectedColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              splashColor: Theme.of(context).accentColor.withOpacity(0.2),
              highlightColor: Colors.deepPurpleAccent.withOpacity(0.2),
              onTap: isAm
                  ? () {
                      onChange("pm");
                    }
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Opacity(
                  opacity: isAm ? unselectedOpacity : 1,
                  child: Text(
                    "pm",
                    style: _style.copyWith(
                      foreground: Paint()
                        ..shader = !isAm ? _selectedColor : _unselectedColor,
                      fontWeight: !isAm ? FontWeight.bold : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
