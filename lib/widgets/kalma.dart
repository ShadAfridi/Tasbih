import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import '../providers/kalmaProvider.dart';
import '../screen/kalmaScreen.dart';
import '../models/kalmaModel.dart';

class Kalma extends StatelessWidget {
  const Kalma({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KalmaProvider _klmData = Provider.of<KalmaProvider>(context);
    KalmaModel _klm = _klmData.kalma;
    bool _kSelected = _klmData.isSelected;
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      child: Positioned(
        top: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.51,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Align(
            alignment: Alignment.center,
            child: (_kSelected && _klm != null)
                ? Text(
                    '${_klm.kalma}',
                    style: TextStyle(
                      color: _isLight
                          ? Colors.white.withOpacity(0.9)
                          : Colors.white60,
                      fontSize: _klm.tdr == 'ltr'
                          ? (_isLight ? 23 : 22)
                          : (_isLight ? 25 : 24.5),
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    textDirection: _klm.tdr == 'ltr'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: _isLight
                        ? NeuButton(
                            padding: const EdgeInsets.all(0),
                            decoration: NeumorphicDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white70,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(KalmaScreen.routeName);
                            },
                          )
                        : MaterialButton(
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white54,
                              size: 45,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(KalmaScreen.routeName);
                            },
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
