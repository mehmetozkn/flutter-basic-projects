import 'package:flutter/material.dart';
import 'package:kelime_ezberleme_uygulamasi/db/db/shared_preferences.dart';
import 'package:kelime_ezberleme_uygulamasi/global_variable.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/main.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
    spRead();
  }

  void spRead() async {
    if (await SP.read('lang') == true) {
      chooseLang = Lang.eng;
    } else {
      chooseLang = Lang.tr;
    }

    switch (await SP.read('which')) {
      case 0:
        chooseQuestionType = Which.learned;
        break;
      case 1:
        chooseQuestionType = Which.unlearned;
        ;
        break;
      case 2:
        chooseQuestionType = Which.all;
        break;
    }

    if (await SP.read("mix") == false) {
      listMixed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "QUEAZY",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Carter",
                            fontSize: 40),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Kelime Ezberle",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Luck", fontSize: 30),
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
