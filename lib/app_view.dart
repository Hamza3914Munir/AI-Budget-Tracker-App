import 'package:budge_tracker_app/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(colorScheme: ColorScheme.light(
        background: Colors.green.shade100,
        onBackground: Colors.black,
        primary: Color(0xFF00B2E7),
        secondary: Color(0xFFE064F7),
        tertiary: Color(0xFFFF8D6C),
        outline: Colors.grey.shade600
      )),
      home: LoginScreen(),
    );
  }
}
