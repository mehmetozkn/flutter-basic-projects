import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tas_kagit_makas_oyunu/oyuncu_secim.dart';

import './bilgisayar_secim.dart';
import './oyuncu_secim.dart';
import 'image.dart';

int oyuncuSkoru = 0;
int bilgisayarSkoru = 0;
String sonucAlani = "";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Text(
              'Oyuncu Bilgileri',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        body: startPage(),
      ),
    );
  }
}

TextEditingController txtname = new TextEditingController();

class startPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.white],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Name : ",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  ),
                  Expanded(
                    child: TextField(
                        controller: txtname,
                        decoration: InputDecoration(
                          // Textfieldin altındaki çizgiyi kaldırır.
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 25),
                        autofocus: true),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                    ),
                    onPressed: () {
                      if (txtname.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                  backgroundColor: Colors.red,
                                  title: new Text(
                                    "Adınızı Girmeden Oyun Başlatılamaz!",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Okey',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OyunPage(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "START",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/ornek.jpeg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OyunPage extends StatefulWidget {
  @override
  State<OyunPage> createState() => _OyunPageState();
}

class _OyunPageState extends State<OyunPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            "Oyun Zamanı",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueGrey),
                              child: Oyuncu()),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueGrey),
                              child: Bilgisayar()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Sonuç = " + sonucAlani,
                  style: TextStyle(fontSize: 25, color: Colors.green[400]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      bilgisayarSecimi = Random().nextInt(3) + 1;

                      if (bilgisayarSecimi == 1) {
                        bilgisayarSecimi == 1;
                        pcImage = Resim().tas;
                      } else if (bilgisayarSecimi == 2) {
                        bilgisayarSecimi == 2;
                        pcImage = Resim().kagit;
                      } else if (bilgisayarSecimi == 3) {
                        bilgisayarSecimi == 3;
                        pcImage = Resim().makas;
                      }
                      kontrol();
                    },
                  );
                },
                child: Text(
                  "PLAY",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('FINISH'),
                  onPressed: () {
                    setState(() {
                      pcImage = Resim().bos;
                      oyuncuImage = Resim().bos;
                      oyuncuSkoru = 0;
                      bilgisayarSkoru = 0;
                      txtname.text = "";
                      sonucAlani = "";
                      oyuncuSecimi = 4;
                      bilgisayarSecimi = 4;
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      txtname.text + " = $oyuncuSkoru",
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Bilgisayar = $bilgisayarSkoru",
                      style: TextStyle(fontSize: 25, color: Colors.deepPurple),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(oyuncuImage),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(pcImage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void kontrol() {
  if ((bilgisayarSecimi == 1 && oyuncuSecimi == 1) ||
      (bilgisayarSecimi == 2 && oyuncuSecimi == 2) ||
      (bilgisayarSecimi == 3 && oyuncuSecimi == 3)) {
    sonucAlani = "Berabere";
  } else if ((bilgisayarSecimi == 1 && oyuncuSecimi == 3) ||
      (bilgisayarSecimi == 2 && oyuncuSecimi == 1) ||
      (bilgisayarSecimi == 3 && oyuncuSecimi == 2)) {
    sonucAlani = "Bilgisayar Kazandı";
    bilgisayarSkoru++;
  } else if ((bilgisayarSecimi == 1 && oyuncuSecimi == 2) ||
      (bilgisayarSecimi == 2 && oyuncuSecimi == 3) ||
      (bilgisayarSecimi == 3 && oyuncuSecimi == 1)) {
    sonucAlani = txtname.text + " Kazandı";
    oyuncuSkoru++;
  }
}
