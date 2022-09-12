import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reminderProvider.dart';

class RepeatDaysPicker extends StatefulWidget {
  @override
  _RepeatDaysPickerState createState() => _RepeatDaysPickerState();
}

class _RepeatDaysPickerState extends State<RepeatDaysPicker> {
  @override
  Widget build(BuildContext context) {
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    ReminderProvider data =
        Provider.of<ReminderProvider>(context, listen: false);
    List<String> _repeatText = data.repDays;
    print(data.repDays);
    final Shader _selectedColor = LinearGradient(
      colors: <Color>[
        Color(0xffde7ac2),
        Colors.deepPurpleAccent,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));

    final Shader _unselectedText = LinearGradient(
      colors: _isLight
          ? <Color>[
              Colors.white,
              Colors.white,
            ]
          : <Color>[
              Colors.black.withOpacity(0.75),
              Colors.black.withOpacity(0.75),
            ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 120.0, 70.0));

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Sunday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Sunday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'S',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..shader = _repeatText.contains("Sunday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Sunday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Sunday');
            });
          } else {
            setState(() {
              _repeatText.add('Sunday');
            });
          }
        },
      ),
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Monday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Monday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'M',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..shader = _repeatText.contains("Monday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Monday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Monday');
            });
          } else {
            setState(() {
              _repeatText.add('Monday');
            });
          }
        },
      ),
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Tuesday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Tuesday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'T',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..shader = _repeatText.contains("Tuesday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Tuesday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Tuesday');
            });
          } else {
            setState(() {
              _repeatText.add('Tuesday');
            });
          }
        },
      ),
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Wednesday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Wednesday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'W',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..shader = _repeatText.contains("Wednesday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Wednesday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Wednesday');
            });
          } else {
            setState(() {
              _repeatText.add('Wednesday');
            });
          }
        },
      ),
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Thursday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Thursday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'T',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..shader = _repeatText.contains("Thursday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Thursday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Thursday');
            });
          } else {
            setState(() {
              _repeatText.add('Thursday');
            });
          }
        },
      ),
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Friday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Friday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'F',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..shader = _repeatText.contains("Friday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Friday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Friday');
            });
          } else {
            setState(() {
              _repeatText.add('Friday');
            });
          }
        },
      ),
      RawMaterialButton(
        shape: CircleBorder(
            side: BorderSide(
                width: 1,
                color: _repeatText.contains("Saturday")
                    ? Colors.deepPurpleAccent
                    : Theme.of(context).accentColor)),
        fillColor: _repeatText.contains("Saturday")
            ? Theme.of(context).accentColor
            : _isLight
                ? Colors.white
                : Colors.transparent,
        constraints: BoxConstraints(
          minWidth: 30,
          minHeight: 30,
          maxHeight: 30,
          maxWidth: 30,
        ),
        padding: EdgeInsets.all(0),
        disabledElevation: 3,
        focusElevation: 3,
        highlightElevation: 3,
        hoverElevation: 3,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Text(
          'S',
          style: TextStyle(
            fontSize: 16,
            foreground: Paint()
              ..shader = _repeatText.contains("Saturday")
                  ? _unselectedText
                  : _selectedColor,
          ),
        ),
        onPressed: () async {
          if (_repeatText.contains("Saturday")) {
            setState(() {
              _repeatText.removeWhere((element) => element == 'Saturday');
            });
          } else {
            setState(() {
              _repeatText.add('Saturday');
            });
          }
        },
      ),
    ]);
  }
}
