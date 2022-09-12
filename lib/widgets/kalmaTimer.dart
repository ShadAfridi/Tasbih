import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/countProvider.dart';
import '../providers/timerProvider.dart';

class KalmaTimer extends StatefulWidget {
  const KalmaTimer({Key key}) : super(key: key);
  @override
  _KalmaTimerState createState() => _KalmaTimerState();
}

class _KalmaTimerState extends State<KalmaTimer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TimerProvider _tim = Provider.of<TimerProvider>(context);
    CountProvider _cnt = Provider.of<CountProvider>(context, listen: false);
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    bool _isVisible = _tim.visibility;
    bool _isPlaying = _tim.isPlaying;
    String _timer = _tim.displayTime;

    if (_isPlaying == false) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: _isVisible ? 1 : 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
                size: 20,
                color: _isLight ? Colors.white : Colors.white70,
              ),
              disabledColor: _isLight ? Colors.white : Colors.white70,
              tooltip: 'Decrement',
              onPressed: _isVisible
                  ? () {
                      if (_cnt.count > 0) {
                        _cnt.decrementCount();
                      }
                    }
                  : null),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _timer,
                style: TextStyle(
                    fontSize: 20,
                    color: _isLight ? Colors.white : Colors.white70),
              ),
            ),
          ),
          IconButton(
              icon: AnimatedIcon(
                progress: _controller,
                icon: AnimatedIcons.pause_play,
                size: 22,
                color: _isLight ? Colors.white : Colors.white70,
              ),
              tooltip: 'Start/Pause',
              disabledColor: _isLight ? Colors.white : Colors.white70,
              onPressed: _isVisible
                  ? () {
                      if (_isPlaying == false) {
                        _tim.startStopwatch();
                        _controller.reverse();
                      } else {
                        _tim.stopStopwatch();
                        _controller.forward();
                      }
                    }
                  : null),
        ],
      ),
    );
  }
}
