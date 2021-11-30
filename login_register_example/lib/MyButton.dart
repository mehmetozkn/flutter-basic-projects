import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? butonYazisi;
  final Color? buttonBackColor;
  final Widget? gecilecekSayfa;

  MyButton({this.butonYazisi, this.buttonBackColor, this.gecilecekSayfa});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonBackColor),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => gecilecekSayfa!),
            );
          },
          child: Text(
            butonYazisi!,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
