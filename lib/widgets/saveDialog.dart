import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cityProvider.dart';
import '../providers/countProvider.dart';
import '../providers/kalmaProvider.dart';
import '../providers/timerProvider.dart';
import '../providers/dashProvider.dart';

class SaveDialog extends StatelessWidget {
  final _scaffoldKey;
  SaveDialog(this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    String _selectedKalma;
    String _tdr;
    Map<String, dynamic> _dhikr;
    CountProvider _conData = Provider.of<CountProvider>(context, listen: false);
    KalmaProvider _klmData = Provider.of<KalmaProvider>(context, listen: false);
    CityProvider _cityData = Provider.of<CityProvider>(context, listen: false);
    TimerProvider _tim = Provider.of<TimerProvider>(context, listen: false);
    DashProvider _dsh = Provider.of<DashProvider>(context, listen: false);
    bool _isLight = Theme.of(context).brightness == Brightness.light;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 360,
        decoration: BoxDecoration(
          color: _isLight ? Colors.white : Theme.of(context).primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _isLight
                  ? Image.asset('assets/images/save.png')
                  : Image.asset('assets/images/savedark.png'),
            )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 0,
                    ),
                    child: Text('Save',
                        style: Theme.of(context).textTheme.headline2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 40,
                      right: 40,
                      bottom: 12,
                    ),
                    child: Text(
                      'Would you like to save your progress to the dashboard?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Colors.grey, height: 1.4),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.antiAlias,
                          splashColor:
                              Theme.of(context).accentColor.withOpacity(0.2),
                          highlightColor:
                              Colors.deepPurpleAccent.withOpacity(0.2),
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).accentColor),
                          ),
                          onPressed: () {
                            _tim.resetStopwatch();
                            _conData.resetCounter();
                            _klmData.resetSelection();
                            _cityData.resetAnim();
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          color: Theme.of(context).accentColor,
                          highlightColor:
                              Colors.deepPurpleAccent.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          clipBehavior: Clip.antiAlias,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                fontSize: 18,
                                color: _isLight
                                    ? Colors.white
                                    : Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
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
                              'Minutes':
                                  (_tim.stopWatch.elapsed.inMinutes % 60),
                              'Seconds':
                                  (_tim.stopWatch.elapsed.inSeconds % 60),
                              'Kalma': _selectedKalma,
                              'Date': DateTime.now(),
                              'tdr': _tdr
                            };
                            _dsh.saveData(_dhikr);
                            _tim.resetStopwatch();
                            _conData.resetCounter();
                            _klmData.resetSelection();
                            _cityData.resetAnim();
                            Navigator.of(context).pop();
                            _scaffoldKey.currentState.showSnackBar(
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
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
