import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../helpers/utils.dart';
import './ampm.dart';
import './dayNightBanner.dart';
import './repeatDaysPicker.dart';

/// Private class. [StatefulWidget] that renders the content of the picker.
class DayNightTimePicker extends StatefulWidget {
  /// **`Required`** Display value. It takes in [TimeOfDay].
  final TimeOfDay value;

  /// **`Required`** Return the new time the user picked as [TimeOfDay].
  final void Function(TimeOfDay) onChange;

  /// _`Optional`_ Return the new time the user picked as [DateTime].
  final void Function(DateTime) onChangeDateTime;

  /// Show the time in TimePicker in 24 hour format.
  final bool is24HrFormat;

  /// Accent color of the TimePicker.
  final Color accentColor;

  /// Accent color of unselected text.
  final Color unselectedColor;

  /// Text displayed for the Cancel button.
  final String cancelText;

  /// Text displayed for the Ok button.
  final String okText;

  /// Image asset used for the Sun.
  final Image sunAsset;

  /// Image asset used for the Moon.
  final Image moonAsset;

  /// Border radius of the [Container] in [double].
  final double borderRadius;

  /// Elevation of the [Modal] in [double].
  final double elevation;

  /// Initialize the picker [Widget]
  DayNightTimePicker({
    Key key,
    @required this.value,
    @required this.onChange,
    this.onChangeDateTime,
    this.is24HrFormat = false,
    this.accentColor,
    this.unselectedColor,
    this.cancelText = "cancel",
    this.okText = "ok",
    this.sunAsset,
    this.moonAsset,
    this.borderRadius,
    this.elevation,
  }) : super(key: key);

  @override
  DayNightTimePickerState createState() => DayNightTimePickerState();
}

/// Picker state class
class DayNightTimePickerState extends State<DayNightTimePicker> {
  /// Current selected hour
  int hour;

  /// Current selected minute
  int minute;

  /// Current selected AM/PM
  String a;

  /// Currently changing the hour section
  bool changingHour = true;

  /// Default Ok/Cancel [TextStyle]
  final okCancelStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  void initState() {
    separateHoursAndMinutes();

    super.initState();
  }

  @override
  void didUpdateWidget(DayNightTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.is24HrFormat != widget.is24HrFormat ||
        oldWidget.value != widget.value) {
      separateHoursAndMinutes();
    }
  }

  /// Separate out the hour and minute from a string
  void separateHoursAndMinutes() {
    int _h = widget.value.hour;
    int _m = widget.value.minute;
    String _a = "am";

    if (!widget.is24HrFormat) {
      if (_h == 0) {
        _h = 12;
      } else if (_h == 12) {
        _a = "pm";
      } else if (_h > 12) {
        _a = "pm";
        _h -= 12;
      }
    }
    setState(() {
      hour = _h;
      minute = _m;
      a = _a;
    });
  }

  /// Change handler for picker
  onChangeTime(double value) {
    if (changingHour) {
      setState(() {
        hour = value.round();
      });
    } else {
      setState(() {
        minute = value.round();
      });
    }
    onOk();
  }

  /// Hnadle should change hour or minute
  changeCurrentSelector(bool isHour) {
    setState(() {
      changingHour = isHour;
    });
  }

  /// [onChange] handler. Return [TimeOfDay]
  onOk() {
    var time = TimeOfDay(
      hour: getHours(hour, a, widget.is24HrFormat),
      minute: minute,
    );
    widget.onChange(time);
    if (widget.onChangeDateTime != null) {
      final now = DateTime.now();
      final dateTime =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      widget.onChangeDateTime(dateTime);
    }
  }

  /// Handler to close the picker
  onCancel() {
    Navigator.of(context).pop();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);
  }

  @override
  Widget build(BuildContext context) {
    final _commonTimeStyles = Theme.of(context).textTheme.headline2.copyWith(
          fontSize: 62,
        );
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    double min = 0;
    double max = 59;
    int divisions = 59;
    double hourMinValue = 1;
    double hourMaxValue = 12;
    if (changingHour) {
      min = 1;
      max = 12;
      divisions = 11;
      if (widget.is24HrFormat) {
        min = 0;
        max = 23;
        divisions = 23;
        hourMinValue = 0;
        hourMaxValue = 23;
      }
    }

    final Shader _selectedColor = LinearGradient(
      colors: <Color>[
        Color(0xffde7ac2),
        Colors.deepPurpleAccent,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

    final Shader _selectedText = LinearGradient(
      colors: <Color>[
        Color(0xffde7ac2),
        Colors.deepPurpleAccent,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 120.0, 70.0));

    final Shader _unselectedColor = LinearGradient(
      colors: <Color>[
        Colors.grey,
        Colors.grey,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 550.0, 70.0));

    final color = widget.accentColor ?? Theme.of(context).accentColor;
    final unselectedColor = widget.unselectedColor ?? Colors.grey;
    final unselectedOpacity = 1.0;

    return Column(
      children: <Widget>[
        DayNightBanner(
          hour: getHours(hour, a, widget.is24HrFormat),
          displace: mapRange(hour * 1.0, hourMinValue, hourMaxValue),
          sunAsset: widget.sunAsset,
          moonAsset: widget.moonAsset,
        ),
        Expanded(
          child: ClipRect(
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: _isLight
                        ? Colors.white
                        : Colors.black.withOpacity(0.85),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 12.0,
                  right: 10.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (!widget.is24HrFormat)
                        AmPm(
                          accentColor: color,
                          unselectedColor: unselectedColor,
                          selected: a,
                          onChange: (e) {
                            setState(() {
                              a = e;
                            });
                            onOk();
                          },
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: InkWell(
                                  splashColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2),
                                  highlightColor:
                                      Colors.deepPurpleAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    changeCurrentSelector(true);
                                  },
                                  child: Opacity(
                                    opacity:
                                        changingHour ? 1 : unselectedOpacity,
                                    child: Text(
                                      "$hour",
                                      style: _commonTimeStyles.copyWith(
                                        foreground: Paint()
                                          ..shader = changingHour
                                              ? _selectedColor
                                              : _unselectedColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(":",
                                style: _commonTimeStyles.copyWith(
                                  foreground: Paint()..shader = _selectedColor,
                                )),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                                highlightColor:
                                    Colors.deepPurpleAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  changeCurrentSelector(false);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Opacity(
                                    opacity:
                                        !changingHour ? 1 : unselectedOpacity,
                                    child: Text(
                                      "${padNumber(minute)}",
                                      style: _commonTimeStyles.copyWith(
                                        foreground: Paint()
                                          ..shader = !changingHour
                                              ? _selectedColor
                                              : _unselectedColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        value: changingHour
                            ? hour.roundToDouble()
                            : minute.roundToDouble(),
                        onChanged: onChangeTime,
                        min: min,
                        max: max,
                        divisions: divisions,
                        activeColor: color,
                        inactiveColor: Colors.deepPurpleAccent.withAlpha(55),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 12),
                        child: Text(
                          'Repeat',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()..shader = _selectedText,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          child: RepeatDaysPicker()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 12),
                        child: Text(
                          'Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()..shader = _selectedText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 4),
                        child: SfDateRangePicker(
                          headerStyle: DateRangePickerHeaderStyle(
                            textStyle: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              color: _isLight
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.8),
                            ),
                          ),
                          selectionTextStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            color: _isLight ? Colors.white : Colors.black,
                          ),
                          selectionRadius: 16,
                          monthViewSettings: DateRangePickerMonthViewSettings(
                              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                color: _isLight ? Colors.black : Colors.white),
                          )),
                          monthCellStyle: DateRangePickerMonthCellStyle(
                            disabledDatesTextStyle: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 13,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            todayTextStyle: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 13,
                              color: Theme.of(context).accentColor,
                            ),
                            todayCellDecoration:
                                BoxDecoration(color: Colors.transparent),
                            textStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 13,
                                color: _isLight ? Colors.black : Colors.white),
                          ),
                          enablePastDates: false,
                          showNavigationArrow: true,
                          onSelectionChanged: _onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.multiple,
                          initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
