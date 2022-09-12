import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import '../screen/kalmaScreen.dart';
import '../screen/settingsScreen.dart';
import '../screen/yourDhikrScreen.dart';
import '../screen/reminderScreen.dart';
import '../screen/aboutScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment(0.0, 0.5),
            child: Text(
              'تَسْبِيح‎',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 85,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: <Color>[
                      Color(0xffde7ac2),
                      Colors.deepPurpleAccent,
                    ],
                  ).createShader(
                    Rect.fromLTWH(100, 0.0, 500, 70.0),
                  ),
                fontFamily: 'Mirza',
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.refresh,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Select Tasbih',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(KalmaScreen.routeName);
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.timeline,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Dashboard',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(YourDhikrScreen.routeName);
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Dhikr Reminder',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(ReminderScreen.routeName);
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            OMIcons.settings,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.info_outline,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'About',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AboutScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).size.height * 0.15,
          )
        ],
      ),
    );
  }
}
