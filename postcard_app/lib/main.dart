import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(BenimUygulamam());
}

class BenimUygulamam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.brown[300],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey,
          title: const Text(
            "My Postcard",
            style: TextStyle(
              color: Colors.indigo,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("images/kahve.jpg"),
                ),
                Text(
                  "Flutter Kahvecisi",
                  style: TextStyle(
                    color: Colors.blueGrey[1000],
                    fontSize: 30,
                    fontFamily: "Satisfy",
                  ),
                ),
                Text("BİR FİNCAN UZAĞINIZDA",
                    style: GoogleFonts.pacifico(
                      color: Colors.white,
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 320,
                  child: Divider(
                    height: 30,
                    color: Colors.brown[900],
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  color: Colors.brown[100],
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      size: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "kahvesipariş.gmail.com",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  color: Colors.brown[100],
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 50,
                    ),
                    title: Text(
                      "+90 534 867 12 34",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
