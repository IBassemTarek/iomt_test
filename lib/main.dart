// @dart=2.9
import 'package:flutter/material.dart';
import 'package:iomt_test/iomt_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const IoMTScreen(),
    );
  }
}
