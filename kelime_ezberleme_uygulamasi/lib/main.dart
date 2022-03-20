import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/temp_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kelime Ezberleme Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempPage(),
    );
  }
}
