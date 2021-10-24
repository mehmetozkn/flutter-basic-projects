import 'package:flutter/material.dart';
import 'constants.dart';
import 'test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: soruSayfasi(),
          ),
        ),
      ),
    );
  }
}

class soruSayfasi extends StatefulWidget {
  @override
  _soruSayfasiState createState() => _soruSayfasiState();
}

class _soruSayfasiState extends State<soruSayfasi> {
  List<Widget> secimler = [];

  Test test_01 = Test();

  void butonFunction(bool selectedButton) {
    if (test_01.sorularBittiMi()) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Congratulations You Have Finished The Test"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Restart'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        test_01.soruIndexSifirla();
                        secimler = [];
                      });
                    },
                  )
                ],
              ));
    } else {
      setState(() {
        bool dogruYanit = test_01.getSoruYaniti();
        dogruYanit ? secimler.add(kDogruIcon) : secimler.add(kYanlisIcon);
        test_01.sonrakiSoru();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                test_01.getSoruMetni(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 3,
          runSpacing: 3,
          children: secimler,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.thumb_up,
                        size: 30,
                      ),
                      onPressed: () {
                        butonFunction(true);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(12.0),
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.thumb_down,
                        size: 30,
                      ),
                      onPressed: () {
                        butonFunction(false);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
