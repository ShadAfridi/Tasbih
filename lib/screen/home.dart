import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../widgets/appDrawer.dart';
import '../providers/countProvider.dart';
import '../providers/cityProvider.dart';
import '../providers/timerProvider.dart';
import '../providers/kalmaProvider.dart';
import '../providers/dashProvider.dart';
import '../widgets/counter.dart';
import '../widgets/city.dart';
import '../widgets/starGroup.dart';
import '../widgets/starGroup2.dart';
import '../widgets/kalma.dart';
import '../widgets/kalmaTimer.dart';
import '../widgets/saveDialog.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    String _selectedKalma;
    String _tdr;
    Map<String, dynamic> _dhikr;
    CountProvider _conData = Provider.of<CountProvider>(context, listen: false);
    CityProvider _cityData = Provider.of<CityProvider>(context, listen: false);
    KalmaProvider _klmData = Provider.of<KalmaProvider>(context, listen: false);
    TimerProvider _tim = Provider.of<TimerProvider>(context, listen: false);
    DashProvider _dsh = Provider.of<DashProvider>(context, listen: false);
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    bool _isPerf = Hive.box('Settings').get('Performance', defaultValue: false);
    bool _isAutoSave =
        Hive.box('Settings').get('isAutoSave', defaultValue: false);

    return Container(
      decoration: BoxDecoration(
        gradient: _isLight
            ? LinearGradient(
                begin: FractionalOffset.topCenter,
                colors: [
                  Color(0xff9c6da5),
                  Color(0xffbd64a4),
                ],
              )
            : LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  Colors.black,
                  Color(0xffbd64a4),
                ],
              ),
      ),
      child: GestureDetector(
        onTap: () {
          if (_conData.count == 0) {
            _tim.startStopwatch();
          }
          _conData.incrementCount();
          _cityData.incrementAnim();
        },
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          drawer: AppDrawer(),
          appBar: AppBar(
            title: KalmaTimer(),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: _isLight ? Colors.white : Colors.white70,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings_backup_restore,
                  size: 20,
                ),
                tooltip: 'Reset',
                onPressed: () {
                  if (_conData.count > 0 || _tim.visibility) {
                    _tim.stopStopwatch();
                    if (!_isAutoSave) {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (ctx) => SaveDialog(_scaffoldKey),
                      ).then(
                        (value) {
                          if (_tim.visibility == true) {
                            _tim.startStopwatch();
                          }
                        },
                      );
                    } else {
                      if (_klmData.isSelected) {
                        _selectedKalma = _klmData.kalma.kalma;
                        _tdr = _klmData.kalma.tdr;
                      } else {
                        _selectedKalma = '';
                        _tdr = 'ltr';
                      }
                      _dhikr = {
                        'Count': _conData.count,
                        'Hours': _tim.stopWatch.elapsed.inHours,
                        'Minutes': (_tim.stopWatch.elapsed.inMinutes % 60),
                        'Seconds': (_tim.stopWatch.elapsed.inSeconds % 60),
                        'Kalma': _selectedKalma,
                        'Date': DateTime.now(),
                        'tdr': _tdr
                      };
                      _dsh.saveData(_dhikr);
                      _tim.resetStopwatch();
                      _conData.resetCounter();
                      _klmData.resetSelection();
                      _cityData.resetAnim();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 1500),
                          elevation: 0,
                          backgroundColor: _isLight
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          content: Text(
                            'Saved to Dashboard  \ud83d\ude07',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 0.4,
                                fontSize: 15,
                                color: _isLight
                                    ? Theme.of(context).accentColor
                                    : Colors.grey),
                          ),
                        ),
                      );
                    }
                  } else if (_klmData.isSelected) {
                    _klmData.resetSelection();
                  }
                },
              )
            ],
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: _isPerf
                ? <Widget>[
                    Container(),
                    Kalma(),
                    Positioned(
                      child: Counter(),
                      top: MediaQuery.of(context).size.height > 800
                          ? MediaQuery.of(context).size.height * .49
                          : MediaQuery.of(context).size.height * .45,
                    ),
                    City(),
                  ]
                : <Widget>[
                    StarGroup(),
                    StarGroup2(),
                    Kalma(),
                    Positioned(
                      child: Counter(),
                      top: MediaQuery.of(context).size.height > 800
                          ? MediaQuery.of(context).size.height * .49
                          : MediaQuery.of(context).size.height * .45,
                    ),
                    City(),
                  ],
          ),
        ),
      ),
    );
  }
}
