import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class card extends StatefulWidget {
  final String? imagePath1;
  final String? team1;
  final String? imagePath2;
  final String? team2;

  card({
    Key? key,
    this.imagePath1,
    this.team1,
    this.imagePath2,
    this.team2,
  }) : super(key: key);

  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Image.asset(
                            widget.imagePath1!,
                          ),
                        ),
                        Text(
                          widget.team1!,
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.005,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        ButtonTheme(
                          minWidth: 20,
                          height: 35.0,
                          buttonColor: Colors.red[700],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  "İPTAL EDİLDİ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                          ),
                        ),
                        Text(
                          "Full Time",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "0 - 0",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Text(
                          "28 Mayıs 2022",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Image.asset(
                            widget.imagePath2!,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0002,
                        ),
                        Text(
                          widget.team2!,
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
