import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/dayNightTimePicker.dart';
import '../providers/reminderProvider.dart';

class EditReminderScreen extends StatelessWidget {
  const EditReminderScreen({Key key}) : super(key: key);
  static const routeName = '/editReminderScreen';

  Color getColor(bool isDay, bool isDusk) {
    if (!isDay) {
      return Colors.blueGrey[900];
    }
    if (isDusk) {
      return Colors.orange[400];
    }
    return Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    ReminderProvider data = Provider.of<ReminderProvider>(context);
    int _hour = data.time.hour;
    TimeOfDay _time = data.time;
    bool isDay = _hour >= 6 && _hour <= 18;
    bool isDusk = _hour >= 16 && _hour <= 18;
    Color _color = getColor(isDay, isDusk);
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      color: _color,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text('Set Reminder',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.white)),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: DayNightTimePicker(
            value: _time,
            onChange: (tod) {
              data.time = tod;
              print(data.time);
            },
            is24HrFormat: false,
          ),
        ),
      ),
    );
  }

  onNotificationInLowerVersions(receivedNotification) {}

  onNotificationClick(payload) {
    print('Payload');
  }
}
