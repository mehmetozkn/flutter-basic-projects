import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String icindekiYazi;
  Color? renk;
  Color? inputRenk;
  MyTextField({required this.icindekiYazi, this.renk, this.inputRenk});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          style: TextStyle(color: inputRenk),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: renk),
            border: OutlineInputBorder(),
            hintText: icindekiYazi,
          ),
        ),
      ),
    );
  }
}
