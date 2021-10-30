import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
      child: TurkBayragi(g: 200),
    ));
  }
}

class TurkBayragi extends StatelessWidget {
  final double g;
  TurkBayragi({required this.g});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: g,
        width: 1.5 * g,
        color: Colors.red,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.25 * g,
              left: 0.25 * g,
              child: Container(
                width: 0.5 * g,
                height: 0.5 * g,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 0.3 * g,
              left: 0.3625 * g,
              child: Container(
                width: 0.4 * g,
                height: 0.4 * g,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 0.375 * g,
              left: 0.7 * g,
              child: Transform(
                transform: Matrix4.rotationZ(-0.02),
                child: Container(
                    child:
                        Icon(Icons.star, size: 0.25 * g, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget kirmiziKutu = Container(height: 300, width: 300, color: Colors.red);
Widget yildiz = Icon(Icons.star, size: 0.25, color: Colors.white);
