import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import '../screen/editReminderScreen.dart';
import '../helpers/NotificationHelper.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key key}) : super(key: key);
  static const routeName = '/reminderScreen';

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  void initState() {
    notificationHelper
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationHelper.setOnNotificationClick(onNotificationClick);
    super.initState();
  }

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
          child: Text('Dhikr Reminder',
              style: Theme.of(context).textTheme.headline1),
        ),
        iconTheme: IconThemeData(
          color: _isLight ? Colors.white : Colors.white70,
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: _isLight ? Colors.white : Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: _isLight
                      ? MediaQuery.of(context).size.height * 0.11
                      : MediaQuery.of(context).size.height * 0.09,
                  child: Image.asset('assets/images/ReminderPng.png')),
              SizedBox(
                height: 12,
              ),
              Text(
                'You have no reminders!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: _isLight ? 20 : 18,
                  color: _isLight
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 9,
              ),
              FlatButton(
                padding: const EdgeInsets.all(0),
                color: Colors.transparent,
                splashColor: Theme.of(context).accentColor.withOpacity(0.2),
                highlightColor: Colors.deepPurpleAccent.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        width: 2, color: Theme.of(context).accentColor)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: _isLight ? 17 : 15,
                          color: Colors.grey,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.grey,
                        size: _isLight ? 17 : 15,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  await notificationHelper.showNotification();
                  Navigator.of(context)
                      .pushNamed(EditReminderScreen.routeName, arguments: {
                    'index': 'New',
                  });
                },
              ),
            ],
          )),
    );
  }

  onNotificationInLowerVersions(receivedNotification) {}

  onNotificationClick(payload) {
    print('Payload');
  }
}
