import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'intro.dart';
// import 'profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
      home: introPage(),
    );
  }
}
