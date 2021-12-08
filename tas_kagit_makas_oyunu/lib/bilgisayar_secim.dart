import 'package:flutter/material.dart';

import 'image.dart';

int bilgisayarSecimi = 0;
String pcImage = Resim().bos;

class Bilgisayar extends StatefulWidget {
  @override
  State<Bilgisayar> createState() => _BilgisayarState();
}

class _BilgisayarState extends State<Bilgisayar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Text(
              "Bilgisayar Seçimi",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            enabled: false,
            title: Text(
              "Taş",
              style: TextStyle(fontSize: 20),
            ),
            leading: Radio(
              value: 1,
              groupValue: bilgisayarSecimi,
              onChanged: (value) {
                setState(() {
                  bilgisayarSecimi = 1;
                  pcImage = Resim().tas;
                });
              },
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            enabled: false,
            title: Text(
              "Kagıt",
              style: TextStyle(fontSize: 20),
            ),
            leading: Radio(
              value: 2,
              groupValue: bilgisayarSecimi,
              onChanged: (value) {
                setState(() {
                  bilgisayarSecimi = 2;
                  pcImage = Resim().kagit;
                });
              },
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            enabled: false,
            title: Text(
              "Makas",
              style: TextStyle(fontSize: 20),
            ),
            leading: Radio(
              value: 3,
              groupValue: bilgisayarSecimi,
              onChanged: (value) {
                bilgisayarSecimi = 3;
                pcImage = Resim().makas;
              },
              activeColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
