import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'card.dart';
import 'methods.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color top = Color(Methods.HexaColorConverter("#000000"));
  Color bottom = Color(Methods.HexaColorConverter("#0d2b24"));
  Color icon_color = Color(Methods.HexaColorConverter("#002626"));

  Widget myTextField(String text) {
    return RotatedBox(
      quarterTurns: -1,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(15.0)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[top, bottom, top],
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(15.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.09,
                        child: Container(
                          color: icon_color,
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  myTextField("Bütün Maçlar"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  myTextField("Fikstür"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  myTextField("Canlı"),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                card(
                  imagePath1: 'assets/images/1.png',
                  team1: 'Sport Refice',
                  imagePath2: 'assets/images/2.jpg',
                  team2: 'Saiguino',
                ),
                SizedBox(height: 12),
                Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 30,
                  indent: 80,
                ),
                card(
                  imagePath1: 'assets/images/3.png',
                  team1: 'Extremadura',
                  imagePath2: 'assets/images/4.png',
                  team2: 'UD Logranes',
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 30,
                  indent: 80,
                ),
                card(
                  imagePath1: 'assets/images/5.png',
                  team1: 'Altınordu',
                  imagePath2: 'assets/images/6.png',
                  team2: 'Adanaspor',
                ),
                SizedBox(height: 12),
                Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 30,
                  indent: 80,
                ),
                card(
                  imagePath1: 'assets/images/7.png',
                  team1: 'Ankaragucu',
                  imagePath2: 'assets/images/8.png',
                  team2: 'Eyüpspor',
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 30,
                  indent: 80,
                ),
                card(
                  imagePath1: 'assets/images/9.png',
                  team1: 'FC Mauerwerk',
                  imagePath2: 'assets/images/10.jpeg',
                  team2: 'Admira Wacker Mooting ||',
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  height: 12,
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 30,
                  indent: 80,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: Colors.green[500],
                      onPressed: () {},
                      child: Text(""),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: appBar(context,
          right: Icon(
            Icons.filter_list_alt,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}
