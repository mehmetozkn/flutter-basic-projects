import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(benimUygulamam());
}

class benimUygulamam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "BUGÜN NE YESEM ?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: yemekSayfasi(),
      ),
    );
  }
}

class yemekSayfasi extends StatefulWidget {
  const yemekSayfasi({Key? key}) : super(key: key);

  @override
  _yemekSayfasiState createState() => _yemekSayfasiState();
}

class _yemekSayfasiState extends State<yemekSayfasi> {
  int corbaNo = 1;
  int yemekNo = 1;
  int tatliNo = 1;
  List<String> corbaAdlari = [
    "Mercimek",
    "Tarhana",
    "Tavuksuyu",
    "Düğün Çorbası",
    "Yoğurtlu Çorba"
  ];

  List<String> yemekAdlari = [
    "Karniyarik",
    "Manti",
    "KuruFasulye",
    "İçli Köfte",
    "Izgara Balık"
  ];

  List<String> tatliAdlari = [
    "Kadayıf",
    "Baklava",
    "Sütlaç",
    "Kazandibi",
    "Dondurma"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlatButton(
                highlightColor: Colors.blue,
                splashColor: Colors.red,
                onPressed: () {
                  setState(() {
                    corbaNo = Random().nextInt(5) + 1;
                  });
                },
                child: Image.asset('images/corba_$corbaNo.jpg'),
              ),
            ),
          ),
          Text(
            corbaAdlari[corbaNo - 1],
            style: TextStyle(fontSize: 20),
          ),
          Container(
            width: 300,
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlatButton(
                highlightColor: Colors.black,
                onPressed: () {
                  setState(() {
                    yemekNo = Random().nextInt(5) + 1;
                  });
                },
                child: Image.asset('images/yemek_$yemekNo.jpg'),
              ),
            ),
          ),
          Text(
            yemekAdlari[yemekNo - 1],
            style: TextStyle(fontSize: 20),
          ),
          Container(
            width: 300,
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlatButton(
                highlightColor: Colors.black,
                onPressed: () {
                  setState(() {
                    tatliNo = Random().nextInt(5) + 1;
                  });
                },
                child: Image.asset('images/tatli_$tatliNo.jpg'),
              ),
            ),
          ),
          Text(
            tatliAdlari[tatliNo - 1],
            style: TextStyle(fontSize: 20),
          ),
          Container(
            width: 300,
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
