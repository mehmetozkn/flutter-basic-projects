import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(DrumMachine());
}

class DrumMachine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: drumPage(),
      ),
    );
  }
}

class drumPage extends StatelessWidget {
  final player = AudioCache();
  void playSound(String ses) {
    player.play('$ses.wav');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildDrumPad('bongo', Colors.green),
                  ),
                  Expanded(
                    child: buildDrumPad('bip', Colors.yellow),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildDrumPad('clap1', Colors.blue),
                  ),
                  Expanded(
                    child: buildDrumPad('clap2', Colors.cyan),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildDrumPad('clap3', Colors.white),
                  ),
                  Expanded(
                    child: buildDrumPad('crash', Colors.red),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildDrumPad('how', Colors.pink),
                  ),
                  Expanded(
                    child: buildDrumPad('ridebel', Colors.brown),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildDrumPad('woo', Colors.deepOrange),
                  ),
                  Expanded(
                    child: buildDrumPad('oobah', Colors.teal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlatButton buildDrumPad(String ses, Color renk) {
    return FlatButton(
      padding: EdgeInsets.all(8),
      onPressed: () {
        playSound(ses);
      },
      child: Container(
        color: renk,
      ),
    );
  }
}
