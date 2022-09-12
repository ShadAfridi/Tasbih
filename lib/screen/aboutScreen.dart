import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);
  static const routeName = '/aboutScreen';
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
          child: Text('About', style: Theme.of(context).textTheme.headline1),
        ),
        iconTheme: IconThemeData(
          color: _isLight ? Colors.white : Colors.white70,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: _isLight ? Colors.white : Colors.black,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
