import 'package:intl/intl.dart' as date;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashProvider.dart';
import '../widgets/lineGraph.dart';

class YourDhikrScreen extends StatelessWidget {
  static const routeName = '/yourDhikrScreen';

  @override
  Widget build(BuildContext context) {
    DashProvider _dsh = Provider.of<DashProvider>(context);
    Map _dta = _dsh.getData;
    List _dtaList = _dta.values.toList();
    List _dtaKeysList = _dta.keys.toList();
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
          child:
              Text('Dashboard', style: Theme.of(context).textTheme.headline1),
        ),
        iconTheme: IconThemeData(
          color: _isLight ? Colors.white : Colors.white70,
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: _dtaList.isEmpty ? 0 : 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: _isLight ? Colors.white : Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: _dtaList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: _isLight
                            ? MediaQuery.of(context).size.height * 0.14
                            : MediaQuery.of(context).size.height * 0.12,
                        child: Image.asset('assets/images/HijabSad.png')),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'You have no dhikr saved!',
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
                      'Start Counting',
                      style: TextStyle(
                        fontSize: _isLight ? 17 : 15,
                        color: Colors.grey,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Column(
                  children: [
                    LineGraph(),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: _dtaList.length,
                          itemBuilder: (context, i) {
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (dir) {
                                _dsh.deleteKalma(_dtaKeysList[i]);
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
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffde7ac2).withOpacity(0.8),
                                      Colors.deepPurpleAccent.withOpacity(0.6),
                                    ],
                                    stops: [
                                      0.45,
                                      1,
                                    ],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${date.DateFormat.E().format(_dtaList[i]['Date']).toString()}, ${date.DateFormat.d().format(_dtaList[i]['Date']).toString()} ${date.DateFormat.MMM().format(_dtaList[i]['Date']).toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _dtaList[i]['Hours'] != 0
                                                ? '${_dtaList[i]['Hours'].toString()} Hrs ${_dtaList[i]['Minutes'].toString()} Mins'
                                                : _dtaList[i]['Minutes'] != 0
                                                    ? '${_dtaList[i]['Minutes'].toString()} Mins ${_dtaList[i]['Seconds'].toString()} Secs'
                                                    : '${_dtaList[i]['Seconds'].toString()} Seconds',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _dtaList[i]['Kalma'].toString().isEmpty
                                            ? 'N/A'
                                            : _dtaList[i]['Kalma']
                                                        .toString()
                                                        .length >
                                                    60
                                                ? '${_dtaList[i]['Kalma'].toString().substring(0, 60)} ... '
                                                : _dtaList[i]['Kalma']
                                                    .toString(),
                                        textDirection:
                                            _dtaList[i]['tdr'] == 'ltr'
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            _dtaList[i]['Count'] < 10
                                                ? '0${_dtaList[i]['Count'].toString()}'
                                                : '${_dtaList[i]['Count'].toString()}',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            ' Counts',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )),
    );
  }
}
