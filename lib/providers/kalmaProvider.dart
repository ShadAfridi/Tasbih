import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import '../models/kalmaModel.dart';

class KalmaProvider with ChangeNotifier {
  dynamic _selInx;
  bool _isSelected = false;
  Box _klmBox = Hive.box<KalmaModel>('Kalma');

  Map get kalmaList {
    Map klmMap = _klmBox.toMap();
    return klmMap;
  }

  KalmaModel get kalma {
    if (_selInx != null)
      return _klmBox.get(_selInx);
    else {
      return null;
    }
  }

  bool get isSelected {
    return _isSelected;
  }

  void selectKalma(dynamic index) {
    Map klmMap = _klmBox.toMap();
    if (klmMap.isNotEmpty) {
      _selInx = index;
      _isSelected = true;
      notifyListeners();
    }
  }

  void addKalma(String klm, TextDirection tdr) async {
    String _direction;
    if (tdr == TextDirection.ltr) {
      _direction = 'ltr';
    } else {
      _direction = 'rtl';
    }
    KalmaModel kalma = KalmaModel(kalma: klm, tdr: _direction);
    _klmBox.add(kalma);
    notifyListeners();
  }

  void deleteKalma(dynamic id) async {
    await _klmBox.delete(id);
    _isSelected = false;
    _selInx = null;
    notifyListeners();
  }

  void resetSelection() {
    if (_isSelected == true) {
      _isSelected = false;
      notifyListeners();
    }
  }
}
