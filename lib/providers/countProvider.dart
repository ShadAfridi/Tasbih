import 'package:flutter/widgets.dart';

class CountProvider with ChangeNotifier {
  static int _c = 0;

  int get count {
    return _c;
  }

  void incrementCount() {
    _c++;
    notifyListeners();
  }

  void decrementCount() {
    _c--;
    notifyListeners();
  }

  void resetCounter() {
    if (_c != 0) {
      _c = 0;
      notifyListeners();
    }
  }
}
