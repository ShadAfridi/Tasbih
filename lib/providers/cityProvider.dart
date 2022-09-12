import 'package:flutter/widgets.dart';

class CityProvider with ChangeNotifier {
  static int _count = 0;
  static String _animText = 'Idle';

  String get anim {
    return _animText;
  }

  void incrementAnim() {
    _count++;
    if (_count % 11 == 0 && _count < 100) {
      _animText = 'Anim $_count';
      notifyListeners();
    } else {
      _animText = 'Idle';
    }
  }

  void resetAnim() {
    if (_count != 0) {
      _count = 0;
      _animText = 'Anim 0';
      notifyListeners();
    }
  }
}
