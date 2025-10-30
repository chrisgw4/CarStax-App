import 'package:car_stax/auth/login_or_register.dart';
import 'package:car_stax/pages/home_page.dart';
import 'package:car_stax/theme/dark_mode.dart';
import 'package:car_stax/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:car_stax/pages/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginOrRegister(),
      theme: light_mode,
      darkTheme: dark_mode,
      routes: {
        '/login_register_page':(context) => LoginOrRegister(),
        '/home_page' : (context) => HomePage(),
      },
    );
  }
}
