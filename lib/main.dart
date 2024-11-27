import 'package:flutter/material.dart';
import 'package:sabzi/Code.dart';
import 'package:sabzi/LoginScreen.dart';
import 'package:sabzi/SplashScreen.dart';
import 'package:sabzi/Whitescreen.dart';
import 'package:sabzi/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/white': (context) => WhiteScreen(),
        '/register': (context) => RegisterScreen(),
        '/code': (context) => CodeEntryScreen(),
      },
    );
  }
}
