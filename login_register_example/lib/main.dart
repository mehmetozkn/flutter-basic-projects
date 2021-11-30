import 'package:flutter/material.dart';
import 'package:login_register_app/MyButton.dart';

import './MyTextField.dart';

void main() {
  runApp(MyApp());
}

Map<String, String> users = Map();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Main Page'),
        ),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.white],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyTextField(
            icindekiYazi: 'Enter your username',
            renk: Colors.limeAccent,
          ),
          MyTextField(
            icindekiYazi: 'Enter your password',
            renk: Colors.limeAccent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                butonYazisi: 'Sign in',
              ),
              MyButton(
                butonYazisi: 'Sign Up',
                gecilecekSayfa: SignUpPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  TextEditingController txtusername = new TextEditingController();
  TextEditingController txtpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Resigter Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueGrey],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTextField(
              icindekiYazi: 'Enter your username',
              renk: Colors.deepOrangeAccent,
              inputRenk: Colors.black,
            ),
            MyTextField(
              icindekiYazi: 'Enter your password',
              renk: Colors.deepOrangeAccent,
              inputRenk: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen),
                  ),
                  onPressed: () {
                    if (txtusername.text.isEmpty || txtpassword.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                title: new Text("Please Fill All Blanks"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Okey'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ));
                    } else {
                      // Kayıt olan kullanıcısın bilgilerini listeye ekler.
                      users.putIfAbsent(
                          txtusername.text, () => txtpassword.text);
                      print(users);
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                title: new Text(
                                    "Congratulations You Have Successfully Registered "),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Okey'),
                                    onPressed: () {
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                    },
                                  ),
                                ],
                              ));
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
