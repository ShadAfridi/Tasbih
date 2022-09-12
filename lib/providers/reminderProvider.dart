import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReminderProvider with ChangeNotifier {
  List<String> _reps = [];
  TimeOfDay _time = TimeOfDay.fromDateTime(DateTime.now());

  set time(time) {
    _time = time;
    notifyListeners();
  }

  TimeOfDay get time {
    return _time;
  }

  List<String> get repDays {
    return _reps;
  }

  void setRepDays(String repDay) {
    _reps.add(repDay);
    notifyListeners();
  }

  void delRepDays(String repDay) {
    _reps.removeWhere((i) {
      return i == repDay;
    });
    notifyListeners();
  }
}
