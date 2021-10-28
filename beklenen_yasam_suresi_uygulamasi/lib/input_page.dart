import 'package:beklenen_yasam_suresi_uygulamasi/result_page.dart';
import 'package:beklenen_yasam_suresi_uygulamasi/user_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './icon_cinsiyet.dart';
import './my_container.dart';
import './constants.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String selectedGender = "";
  double icilenSigara = 0.0;
  double sporSayisi = 0.0;
  int boy = 170;
  int kilo = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YAŞAM BEKLENTİSİ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: MyContainer(
                    child: buildRowOutlineButton("BOY"),
                  ),
                ),
                Expanded(
                  child: MyContainer(
                    child: buildRowOutlineButton("KİLO"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Haftada Kaç Kez Spor Yapıyorsunuz ?",
                      style: metinStili),
                  Text(sporSayisi.round().toString(), style: sayiStili),
                  Slider(
                    min: 0,
                    max: 7,
                    value: sporSayisi,
                    onChanged: (double value) {
                      setState(() {
                        sporSayisi = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: MyContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Günde Kaç Sigara İçiyorsunuz ?", style: metinStili),
                  Text(icilenSigara.round().toString(), style: sayiStili),
                  Slider(
                    min: 0,
                    max: 30,
                    value: icilenSigara,
                    onChanged: (double value) {
                      setState(() {
                        icilenSigara = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MyContainer(
                    onPress: () {
                      setState(() {
                        selectedGender = "FEMALE";
                      });
                    },
                    renk: selectedGender == "FEMALE"
                        ? Colors.lightBlue[100]!
                        : Colors.white,
                    child: IconCinsiyet(
                      gender: "FEMALE",
                      icon: FontAwesomeIcons.venus,
                    ),
                  ),
                ),
                Expanded(
                  child: MyContainer(
                    onPress: () {
                      setState(() {
                        selectedGender = "MALE";
                      });
                    },
                    renk: selectedGender == "MALE"
                        ? Colors.lightBlue[100]!
                        : Colors.white,
                    child: IconCinsiyet(
                      gender: "MALE",
                      icon: FontAwesomeIcons.mars,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonTheme(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: FlatButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultPage(UserData(
                              kilo: kilo,
                              boy: boy,
                              selectedGender: selectedGender,
                              sporSayisi: sporSayisi,
                              icilenSigara: icilenSigara))));
                },
                child: Text(
                  "HESAPLA",
                  style: metinStili,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildRowOutlineButton(
    String label,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RotatedBox(
            quarterTurns: -1,
            child: Text(
              label,
              style: metinStili,
            )),
        RotatedBox(
            quarterTurns: -1,
            child: Text(
              label == "BOY" ? boy.toString() : kilo.toString(),
              style: sayiStili,
            )),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 36,
              child: OutlineButton(
                  borderSide: BorderSide(color: Colors.lightBlue),
                  child: Icon(FontAwesomeIcons.plus),
                  onPressed: () {
                    setState(() {
                      label == "BOY" ? boy++ : kilo++;
                    });
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 36,
              child: OutlineButton(
                  borderSide: BorderSide(color: Colors.lightBlue),
                  child: Icon(FontAwesomeIcons.minus),
                  onPressed: () {
                    setState(() {
                      label == "BOY" ? boy-- : kilo--;
                    });
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
