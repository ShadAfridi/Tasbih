import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);
  static const routeName = '/settingsScreen';
  @override
  Widget build(BuildContext context) {
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: _isLight
          ? Theme.of(context).accentColor
          : Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _isLight
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text('Settings', style: Theme.of(context).textTheme.headline1),
        ),
        iconTheme: IconThemeData(
          color: _isLight ? Colors.white : Colors.white70,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: _isLight ? Colors.white : Colors.black,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Dark Mode'),
              subtitle: Text('Turns on a dark theme'),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value:
                    Hive.box('Settings').get('isDarkMode', defaultValue: false),
                onChanged: (val) {
                  var darkMode = Hive.box('Settings')
                      .get('isDarkMode', defaultValue: false);
                  Hive.box('Settings').put('isDarkMode', !darkMode);
                },
              ),
            ),
            ListTile(
              title: Text('Performance Mode'),
              isThreeLine:
                  MediaQuery.of(context).size.width <= 360 ? true : false,
              subtitle: Text('Limits animations to increase performance'),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value: Hive.box('Settings')
                    .get('Performance', defaultValue: false),
                onChanged: (val) {
                  var perf = Hive.box('Settings')
                      .get('Performance', defaultValue: false);
                  Hive.box('Settings').put('Performance', !perf);
                },
              ),
            ),
            ListTile(
              title: Text('Auto Save'),
              isThreeLine:
                  MediaQuery.of(context).size.width <= 395 ? true : false,
              subtitle: Text('Saves your progress without showing a diaglogue'),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value:
                    Hive.box('Settings').get('isAutoSave', defaultValue: false),
                onChanged: (val) {
                  var autoSave = Hive.box('Settings')
                      .get('isAutoSave', defaultValue: false);
                  Hive.box('Settings').put('isAutoSave', !autoSave);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
