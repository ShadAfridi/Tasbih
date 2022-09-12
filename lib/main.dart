import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import './helpers/ColorGen.dart';
import './providers/reminderProvider.dart';
import './providers/kalmaProvider.dart';
import './providers/countProvider.dart';
import './providers/cityProvider.dart';
import './providers/timerProvider.dart';
import './providers/dashProvider.dart';
import './models/kalmaModel.dart';
import './screen/home.dart';
import './screen/settingsScreen.dart';
import './screen/yourDhikrScreen.dart';
import './screen/kalmaScreen.dart';
import './screen/reminderScreen.dart';
import './screen/aboutScreen.dart';
import './screen/editReminderScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(_appDocumentDirectory.path);
  Hive.registerAdapter(KalmaModelAdapter());
  await Hive.openBox<KalmaModel>('Kalma');
  await Hive.openBox<bool>('isStart');
  bool box = Hive.box<bool>('isStart').get('isStart', defaultValue: true);
  if (box == true) {
    await Hive.box<bool>('isStart').put('isStart', false);
    await Hive.box<KalmaModel>('Kalma')
        .add(KalmaModel(kalma: 'سُبْحَانَ ٱللَّٰهِ', tdr: 'rtl'));
    await Hive.box<KalmaModel>('Kalma')
        .add(KalmaModel(kalma: 'ٱلْحَمْدُ لِلَّٰهِ‎', tdr: 'rtl'));
    await Hive.box<KalmaModel>('Kalma')
        .add(KalmaModel(kalma: 'ٱللَّٰهُ أَكْبَرُ', tdr: 'rtl'));
    await Hive.box<KalmaModel>('Kalma').add(KalmaModel(
        kalma:
            'اَشْهَدُ اَنْ لَّآ اِلٰهَ اِلَّا اللهُ وَحْدَہٗ لَاشَرِيْكَ لَہٗ وَاَشْهَدُ اَنَّ مُحَمَّدًا عَبْدُهٗ وَرَسُولُہٗ‎	',
        tdr: 'rtl'));
    await Hive.box<KalmaModel>('Kalma')
        .add(KalmaModel(kalma: 'Subhan Allah', tdr: 'ltr'));
    await Hive.box<KalmaModel>('Kalma')
        .add(KalmaModel(kalma: 'Alhamdulillah', tdr: 'ltr'));
    await Hive.box<KalmaModel>('Kalma')
        .add(KalmaModel(kalma: 'Allahu Akbar', tdr: 'ltr'));
  }
  await Hive.openBox('Settings');
  await Hive.openBox('SaveData');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: CountProvider(),
        ),
        ChangeNotifierProvider.value(
          value: KalmaProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CityProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TimerProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DashProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ReminderProvider(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box('Settings').listenable(),
        builder: (context, box, snap) {
          var _darkMode = box.get('isDarkMode', defaultValue: false);
          return MaterialApp(
            title: 'Tasbih',
            debugShowCheckedModeBanner: false,
            themeMode: _darkMode == true ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'Lato',
              accentColor: Color(0xffde7ac2),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Color(0xffbd64a4),
              ),
              textTheme: TextTheme(
                headline1: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 24,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400,
                ),
                overline: TextStyle(
                  fontSize: 21,
                  color: Colors.white.withOpacity(0.8),
                ),
                button: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
                headline2: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 24,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Lato',
              accentColor: Color(0xffde7ac2),
              textSelectionTheme:
                  TextSelectionThemeData(cursorColor: Color(0xffbd64a4)),
              primarySwatch: generateMaterialColor(Color(0xffbd64a4)),
              textTheme: TextTheme(
                headline1: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400,
                ),
                overline: TextStyle(
                  fontSize: 24,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[
                        Color(0xffde7ac2),
                        Colors.deepPurpleAccent,
                      ],
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, 90, 70.0),
                    ),
                ),
                button: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
                headline2: TextStyle(
                  color: Color(0xffde7ac2),
                  fontSize: 24,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            initialRoute: Home.routeName,
            routes: {
              Home.routeName: (context) => Home(
                    title: 'Tasbih',
                  ),
              SettingsScreen.routeName: (context) => SettingsScreen(),
              YourDhikrScreen.routeName: (context) => YourDhikrScreen(),
              KalmaScreen.routeName: (context) => KalmaScreen(),
              ReminderScreen.routeName: (context) => ReminderScreen(),
              EditReminderScreen.routeName: (context) => EditReminderScreen(),
              AboutScreen.routeName: (context) => AboutScreen(),
            },
          );
        },
      ),
    );
  }
}
