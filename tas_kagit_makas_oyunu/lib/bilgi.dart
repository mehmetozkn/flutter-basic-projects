import 'package:flutter/material.dart';

class Bilgi extends StatelessWidget {
  String bilgi;
  Bilgi({required this.bilgi});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sonuç = ",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          Text(
            bilgi + " Kazandı",
            style: TextStyle(fontSize: 20, color: Colors.green[600]),
          ),
        ],
      ),
    );
  }
}
