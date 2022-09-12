import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/kalmaProvider.dart';
import '../widgets/kalmaTextField.dart';

class KalmaScreen extends StatelessWidget {
  static const routeName = '/kalmaScreen';

  @override
  Widget build(BuildContext context) {
    KalmaProvider _klmData = Provider.of<KalmaProvider>(context);
    Map _klmMap = _klmData.kalmaList;
    List _klmList = _klmMap.values.toList();
    List _klmKeysList = _klmMap.keys.toList();
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
          child: Text('Select Tasbih',
              style: Theme.of(context).textTheme.headline1),
        ),
        iconTheme: IconThemeData(
          color: _isLight ? Colors.white : Colors.white70,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: _isLight ? Colors.white : Colors.black,
                    borderRadius: _isLight
                        ? BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                        : BorderRadius.circular(20),
                  ),
                  child: _klmMap.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: _isLight
                                      ? MediaQuery.of(context).size.height *
                                          0.14
                                      : MediaQuery.of(context).size.height *
                                          0.12,
                                  child: Image.asset(
                                      'assets/images/HijabSad.png')),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Tasbih list empty!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: _isLight ? 20 : 18,
                                  color: _isLight
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).accentColor,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Add a tasbih',
                                style: TextStyle(
                                  fontSize: _isLight ? 17 : 15,
                                  color: Colors.grey,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemCount: _klmMap.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (dir) {
                                    _klmData.deleteKalma(_klmKeysList[index]);
                                  },
                                  background: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  secondaryBackground: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    alignment: Alignment.centerRight,
                                  ),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      _klmData.selectKalma(_klmKeysList[index]);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '${index + 1}',
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _klmList[index].kalma,
                                              textAlign:
                                                  _klmList[index].tdr == 'ltr'
                                                      ? TextAlign.end
                                                      : TextAlign.start,
                                              textDirection:
                                                  _klmList[index].tdr == 'ltr'
                                                      ? TextDirection.ltr
                                                      : TextDirection.rtl,
                                              style: TextStyle(
                                                fontSize:
                                                    _klmList[index].tdr == 'ltr'
                                                        ? _isLight ? 20 : 19
                                                        : _isLight ? 23 : 20,
                                                color: _isLight
                                                    ? Colors.grey[700]
                                                    : Colors.white
                                                        .withOpacity(0.8),
                                                letterSpacing:
                                                    _klmList[index].tdr == 'ltr'
                                                        ? 1
                                                        : 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider()
                              ],
                            );
                          },
                        ),
                ),
              ),
              Container(
                color: _isLight ? Colors.white : Theme.of(context).primaryColor,
                height: 120,
              )
            ],
          ),
          KalmaTextField(),
        ],
      ),
    );
  }
}
