import 'package:intl/intl.dart' as date;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/dashProvider.dart';

class LineGraph extends StatefulWidget {
  LineGraph({Key key}) : super(key: key);

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  final List<Color> _gradientColors = [
    Color(0xffde7ac2),
    Colors.deepPurpleAccent,
  ];

  final Shader _selectedColor = LinearGradient(
    colors: <Color>[
      Color(0xffde7ac2),
      Colors.deepPurpleAccent,
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

  final Shader _unselectedColor = LinearGradient(
    colors: <Color>[
      Colors.grey,
      Colors.grey,
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  String _isSelected;

  @override
  void initState() {
    _isSelected = 'Weekly';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    DashProvider _dsh = Provider.of<DashProvider>(context);
    Map _dta = _dsh.getData;
    List _dtaList = _dta.values.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _isSelected = 'Weekly';
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Weekly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        foreground: Paint()
                          ..shader = _isSelected == 'Weekly'
                              ? _selectedColor
                              : _unselectedColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _isSelected = 'Monthly';
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Monthly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        foreground: Paint()
                          ..shader = _isSelected == 'Monthly'
                              ? _selectedColor
                              : _unselectedColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _isSelected = 'Yearly';
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Yearly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        foreground: Paint()
                          ..shader = _isSelected == 'Yearly'
                              ? _selectedColor
                              : _unselectedColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: 6,
          ),
          height: 180,
          child: LineChart(
            mainData(_isLight, _dtaList, _isSelected),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(bool _isLight, List<dynamic> _dta, String sel) {
    DateTime _dat =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List<String> dates = [];
    List<int> counts = [];
    if (sel == 'Weekly') {
      for (int i = 0; i < 7; i++) {
        if (i > 0) _dat = _dat.subtract(Duration(days: 1));

        int count = 0;
        String dt = date.DateFormat.E().format(_dat);
        _dta
            .where(
              (element) => (element['Date'].day == _dat.day &&
                  element['Date'].month == _dat.month &&
                  element['Date'].year == _dat.year),
            )
            .toList()
              ..forEach(
                (element) {
                  if (element['Count'] < 1000) {
                    count = count + element['Count'];
                  } else {
                    count = 1000;
                  }
                },
              );
        counts.add(count);
        dates.add(dt);
      }
    } else if (sel == 'Monthly') {
      for (int i = 0; i < 12; i++) {
        int count = 0;
        if (i > 0) {
          if (_dat.month == 1) {
            _dat = DateTime(_dat.year - 1, 12);
          } else {
            _dat = DateTime(_dat.year, _dat.month - 1);
          }
        }
        _dta
            .where((element) => (element['Date'].month == _dat.month &&
                element['Date'].year == _dat.year))
            .toList()
              ..forEach(
                (element) {
                  if (element['Count'] < 1000) {
                    count = count + element['Count'];
                  } else {
                    count = 1000;
                  }
                },
              );
        counts.add(count);
        dates.add(date.DateFormat.MMM().format(_dat));
      }
    } else if (sel == 'Yearly') {
      for (int i = 0; i < 8; i++) {
        int count = 0;
        if (i > 0) {
          _dat = DateTime(_dat.year - 1);
        }
        _dta.where((element) => (element['Date'].year == _dat.year)).toList()
          ..forEach(
            (element) {
              if (element['Count'] < 5000) {
                count = count + element['Count'];
              } else {
                count = 5000;
              }
            },
          );
        counts.add(count);
        dates.add(date.DateFormat.y().format(_dat));
      }
    }

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: _isLight ? Colors.white54 : Colors.black54,
          fitInsideHorizontally: true,
          fitInsideVertically: false,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 15,
          getTextStyles: (value) => TextStyle(
            color: Color(0xff68737d),
            fontSize: 12,
          ),
          getTitles: sel == 'Monthly'
              ? (value) {
                  switch (value.toInt()) {
                    case 1:
                      return dates[11];
                    case 2:
                      return dates[10];
                    case 3:
                      return dates[9];
                    case 4:
                      return dates[8];
                    case 5:
                      return dates[7];
                    case 6:
                      return dates[6];
                    case 7:
                      return dates[5];
                    case 8:
                      return dates[4];
                    case 9:
                      return dates[3];
                    case 10:
                      return dates[2];
                    case 11:
                      return dates[1];
                    case 12:
                      return dates[0];
                  }
                  return '';
                }
              : (value) {
                  switch (value.toInt()) {
                    case 1:
                      return dates[6];
                    case 2:
                      return dates[5];
                    case 3:
                      return dates[4];
                    case 4:
                      return dates[3];
                    case 5:
                      return dates[2];
                    case 6:
                      return dates[1];
                    case 7:
                      return dates[0];
                  }
                  return '';
                },
          margin: 15,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Color(0xff67727d),
            fontSize: 12,
          ),
          getTitles: sel == 'Yearly'
              ? (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '0';

                    case 1000:
                      return '1000';

                    case 2000:
                      return '2000';

                    case 3000:
                      return '3000';

                    case 4000:
                      return '4000';

                    case 5000:
                      return '>5000';
                  }
                  return '';
                }
              : (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '0';

                    case 200:
                      return '200';

                    case 400:
                      return '400';

                    case 600:
                      return '600';

                    case 800:
                      return '800';

                    case 1000:
                      return '>1000';
                  }
                  return '';
                },
          reservedSize: 28,
          margin: 10,
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(
        show: false,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      minX: 0,
      maxX: sel == 'Monthly' ? 13 : 8,
      minY: 0,
      maxY: sel == 'Yearly' ? 5000 : 1000,
      lineBarsData: [
        LineChartBarData(
          spots: sel == 'Monthly'
              ? [
                  FlSpot(0, 0),
                  FlSpot(1, counts[11].toDouble()),
                  FlSpot(2, counts[10].toDouble()),
                  FlSpot(3, counts[9].toDouble()),
                  FlSpot(4, counts[8].toDouble()),
                  FlSpot(5, counts[7].toDouble()),
                  FlSpot(6, counts[6].toDouble()),
                  FlSpot(7, counts[5].toDouble()),
                  FlSpot(8, counts[4].toDouble()),
                  FlSpot(9, counts[3].toDouble()),
                  FlSpot(10, counts[2].toDouble()),
                  FlSpot(11, counts[1].toDouble()),
                  FlSpot(12, counts[0].toDouble()),
                  FlSpot(13, 0),
                ]
              : [
                  FlSpot(0, 0),
                  FlSpot(1, counts[6].toDouble()),
                  FlSpot(2, counts[5].toDouble()),
                  FlSpot(3, counts[4].toDouble()),
                  FlSpot(4, counts[3].toDouble()),
                  FlSpot(5, counts[2].toDouble()),
                  FlSpot(6, counts[1].toDouble()),
                  FlSpot(7, counts[0].toDouble()),
                  FlSpot(8, 0),
                ],
          isCurved: false,
          colors: _gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: _gradientColors
                .map(
                  (color) => color.withOpacity(0.3),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
