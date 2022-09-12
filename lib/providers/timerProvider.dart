import 'dart:async';
import 'package:flutter/widgets.dart';

class TimerProvider with ChangeNotifier {
  bool _isVisible = false;
  bool _isPlaying = false;
  bool _isStopped = false;
  String _displayTime = '00:00:00';
  Stopwatch _stwatch = Stopwatch();
  final Duration _dur = Duration(seconds: 1);

  bool get visibility {
    return _isVisible;
  }

  bool get isPlaying {
    return _isPlaying;
  }

  bool get isStopped {
    return _isStopped;
  }

  String get displayTime {
    return _displayTime;
  }

  Stopwatch get stopWatch {
    return _stwatch;
  }

  void startStopwatch() {
    _isPlaying = true;
    _isVisible = true;
    notifyListeners();
    _stwatch.start();
    startTimer();
  }

  void startTimer() {
    Timer(_dur, keepRunning);
  }

  void keepRunning() {
    if (_stwatch.isRunning) {
      startTimer();
    }
    _displayTime = _stwatch.elapsed.inHours.toString().padLeft(2, '0') +
        ':' +
        (_stwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
        ':' +
        (_stwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');

    notifyListeners();
  }

  void stopStopwatch() {
    if (_stwatch.isRunning) {
      _stwatch.stop();
      _isPlaying = false;
      notifyListeners();
    }
  }

  void resetStopwatch() {
    if (_isVisible) {
      _stwatch.stop();
      _stwatch.reset();
      _isPlaying = false;
      _isVisible = false;
      _displayTime = '00:00:00';
      notifyListeners();
    }
  }
}
