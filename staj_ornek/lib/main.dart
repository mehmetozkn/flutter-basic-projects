import 'package:flutter/material.dart';
import 'package:staj_ornek/empty_page.dart';

import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  Widget _currentPage = EmptyPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
      backgroundColor: Colors.white,
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int) {
          setState(() {
            _currentIndex = int;
            _currentPage = (int == 2) ? MainPage() : EmptyPage();
          });
        },
        currentIndex: _currentIndex,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black87,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: new Text(
                'Maçlar',
                style: TextStyle(color: Colors.white),
              ),
              icon: new Icon(Icons.nfc)),
          BottomNavigationBarItem(
              title: new Text(
                'Analiz',
                style: TextStyle(color: Colors.white),
              ),
              icon: new Icon(Icons.school)),
          BottomNavigationBarItem(
              title: new Text(
                'Anasayfa',
                style: TextStyle(color: Colors.white),
              ),
              icon: new Icon(Icons.apps)),
          BottomNavigationBarItem(
              title: new Text(
                'Ligler',
                style: TextStyle(color: Colors.white),
              ),
              icon: new Icon(Icons.bar_chart)),
          BottomNavigationBarItem(
              title: new Text(
                'Profil',
                style: TextStyle(color: Colors.white),
              ),
              icon: new Icon(Icons.person)),
        ],
      ),
    );
  }
}
