import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/kalmaProvider.dart';

class KalmaTextField extends StatefulWidget {
  KalmaTextField({Key key}) : super(key: key);

  @override
  _KalmaTextFieldState createState() => _KalmaTextFieldState();
}

class _KalmaTextFieldState extends State<KalmaTextField> {
  TextEditingController _controller;
  FocusNode _fcs;
  bool _isEnglish;

  @override
  void initState() {
    _controller = TextEditingController();
    _isEnglish = true;
    _fcs = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fcs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextDirection _tdr = _isEnglish ? TextDirection.ltr : TextDirection.rtl;
    KalmaProvider _klmData = Provider.of<KalmaProvider>(context, listen: false);
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: _isLight
                    ? LinearGradient(
                        colors: [
                          Color(0xffde7ac2),
                          Colors.deepPurpleAccent.withOpacity(0.5),
                        ],
                        stops: [
                          0.45,
                          1,
                        ],
                      )
                    : null,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                    blurRadius: 5.5,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Theme.of(context).accentColor,
                border: Border.all(
                    width: _isLight ? 4 : 2,
                    color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(50),
              ),
              height: 50,
              width: 140,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AnimatedAlign(
                    alignment: _isEnglish
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    child: Material(
                      elevation: 1.5,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: _isLight
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        width: 140 / 2,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (!_isEnglish) {
                            setState(
                              () {
                                _isEnglish = true;
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 140 / 2,
                          alignment: Alignment.center,
                          child: Text(
                            'English',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              height: 0.9,
                              color: _isEnglish
                                  ? Theme.of(context).accentColor
                                  : (_isLight
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (_isEnglish) {
                            setState(
                              () {
                                _isEnglish = false;
                              },
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: _isLight ? (140 / 2 - 12) : (140 / 2 - 5),
                          child: Text(
                            'عربي',
                            style: TextStyle(
                              fontFamily: 'Mirza',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              height: 0.1,
                              color: _isEnglish
                                  ? (_isLight
                                      ? Colors.white
                                      : Theme.of(context).primaryColor)
                                  : _isLight
                                      ? Colors.deepPurpleAccent
                                      : Theme.of(context).accentColor,
                            ),
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  blurRadius: 5.5,
                  offset: Offset(0, 4),
                ),
              ],
              color: Theme.of(context).accentColor,
              border: Border.all(
                  width: _isLight ? 4 : 2,
                  color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Directionality(
                    textDirection: _tdr,
                    child: TextField(
                      key: Key('Key'),
                      maxLines: 5,
                      minLines: 1,
                      controller: _controller,
                      focusNode: _fcs,
                      enabled: true,
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: _isLight
                              ? Colors.black54
                              : Colors.white.withOpacity(0.35),
                          fontSize: 16,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        labelText: _isEnglish
                            ? 'Enter your tasbih'
                            : 'أدخل التسبيح الخاص بك',
                        filled: true,
                        fillColor: _isLight
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(right: 5),
                  icon: Icon(
                    Icons.add,
                    color: _isLight
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    size: 35,
                  ),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      _klmData.addKalma(_controller.text.trim(), _tdr);
                      _controller.clear();
                      _controller.clearComposing();
                      _fcs.unfocus();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
