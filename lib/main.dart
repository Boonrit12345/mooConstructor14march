import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mooconstructor14march/widget/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ห้ามหมุน
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
    );
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false, // ปิดป้าย Debug มุมบนขวา
      home: Authen(),
    );
  }
}
