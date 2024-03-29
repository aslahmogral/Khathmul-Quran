
// import 'package:daily_quran/screens/juz_section/juz_screen.dart';
import 'package:flutter/material.dart';
import 'package:khathmul_quran/juz_index_screen.dart';
import 'package:khathmul_quran/juz_provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


// late Box box;
Future<void> main() async {
  // await Hive.initFlutter();
  // box = await Hive.openBox('box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JuzProgressProvider()),
        // ChangeNotifierProvider(create: (_) => SurahProgressProvider()),

      ],
      child: MaterialApp(
          title: 'Daily Quran',
          theme: ThemeData(
            fontFamily: 'Poppins',
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          // home: BottomNavBar()),
          // home: TestScreen()),
          home: JuzIndexScreen()),
    );
  }
}
