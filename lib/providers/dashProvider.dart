import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class DashProvider with ChangeNotifier {
  Box _saveBox = Hive.box('SaveData');
  void saveData(Map<String, dynamic> _svData) {
    _saveBox.add(_svData);
  }

  Map get getData {
    Map dta = _saveBox.toMap();
    return dta;
  }

  void deleteKalma(dynamic id) async {
    await _saveBox.delete(id);
    notifyListeners();
  }
}
