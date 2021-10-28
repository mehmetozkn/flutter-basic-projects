import 'package:beklenen_yasam_suresi_uygulamasi/constants.dart';
import 'package:flutter/material.dart';
import 'hesap.dart';
import 'user_data.dart';

class ResultPage extends StatelessWidget {
  final UserData _userData;
  ResultPage(this._userData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Sonuç Sayfası"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Beklenen Yaşam Süresi\n\n" +
                    Hesap(_userData).calculate().round().toString(),
                style: metinStili,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Expanded(
                flex: 1,
                child: ButtonTheme(
                  height: 60,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "GERİ DÖN",
                      style: metinStili,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
