import 'package:flutter/material.dart';

import './image.dart';

String oyuncuImage = Resim().bos;

int oyuncuSecimi = 0;

class Oyuncu extends StatefulWidget {
  @override
  State<Oyuncu> createState() => _OyuncuState();
}

class _OyuncuState extends State<Oyuncu> {
  @override
  Widget build(BuildContext context) {
    if (oyuncuSecimi == 0) {}
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              "Oyuncu Seçimi",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              "Taş",
              style: TextStyle(fontSize: 20),
            ),
            leading: Radio(
              value: 1,
              groupValue: oyuncuSecimi,
              onChanged: (value) {
                setState(() {
                  oyuncuSecimi = 1;
                  oyuncuImage = Resim().tas;
                });
              },
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: Text(
              "Kagıt",
              style: TextStyle(fontSize: 20),
            ),
            leading: Radio(
              value: 2,
              groupValue: oyuncuSecimi,
              onChanged: (value) {
                setState(() {
                  oyuncuSecimi = 2;
                  oyuncuImage = Resim().kagit;
                });
              },
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: Text(
              "Makas",
              style: TextStyle(fontSize: 20),
            ),
            leading: Radio(
              value: 3,
              groupValue: oyuncuSecimi,
              onChanged: (value) {
                setState(() {
                  oyuncuSecimi = 3;
                  oyuncuImage = Resim().makas;
                });
              },
              activeColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
