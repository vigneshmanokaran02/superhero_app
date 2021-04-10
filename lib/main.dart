import 'package:flutter/material.dart'; //Packages Are Used To Bulid App Quickly
import './screens/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: DashBoard());
  }
}
