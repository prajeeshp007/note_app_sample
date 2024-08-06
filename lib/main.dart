import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app_sample/utils/app_sessions.dart';
import 'package:note_app_sample/view/splash_screen/splash_screen.dart';

void main() async {
  ///step 1 hive adding

  await Hive.initFlutter();
  var box = await Hive.openBox(AppSessions.NOTEBOX);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
