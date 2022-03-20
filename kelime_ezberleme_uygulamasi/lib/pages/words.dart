import 'package:flutter/material.dart';
import 'package:kelime_ezberleme_uygulamasi/db/db/db.dart';
import 'package:kelime_ezberleme_uygulamasi/db/models/words.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/app_bar.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/toast.dart';
import 'package:kelime_ezberleme_uygulamasi/methods.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/add_word.dart';

class WordsPage extends StatefulWidget {
  final int? listID;
  final String? listName;
  const WordsPage(this.listID, this.listName, {Key? key}) : super(key: key);

  @override
  _WordsPageState createState() =>
      _WordsPageState(listID: listID, listName: listName);
}

class _WordsPageState extends State<WordsPage> {
  int? listID;
  String? listName;
  _WordsPageState({@required this.listID, @required this.listName});
  List<Word> _wordList = [];
  bool pressController = false;
  List<bool> deleteIndexList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(listID.toString() + " " + listName!);
    getWordByList();
  }

  void getWordByList() async {
    _wordList = await DB.instance.readWordByList(listID);
    for (int i = 0; i < _wordList.length; ++i) deleteIndexList.add(false);
    setState(() => _wordList);
  }

  void delete() async {
    List<int> removeIndexList = [];

    for (int i = 0; i < deleteIndexList.length; ++i) {
      if (deleteIndexList[i]) removeIndexList.add(i);
    }

    for (int i = removeIndexList.length - 1; i >= 0; --i) {
      DB.instance.deleteWord(_wordList[removeIndexList[i]].id!);
      _wordList.removeAt(removeIndexList[i]);
      deleteIndexList.removeAt(removeIndexList[i]);
    }

    setState(() {
      _wordList;
      deleteIndexList;
      pressController = false;
    });

    toastMessage("Seçili Kelimeler Silindi.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 22,
        ),
        center: Text(
          listName!,
          style: TextStyle(
              fontFamily: "carter", fontSize: 22, color: Colors.black),
        ),
        right: pressController != true
            ? Image.asset(
                'assets/images/logo.png',
                height: 35,
                width: 35,
              )
            : InkWell(
                child: Icon(
                  Icons.delete,
                  color: Colors.deepPurpleAccent,
                  size: 24,
                ),
              ),
        leftWidgetOnClick: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return wordItem(_wordList[index].id!, index,
                  word_eng: _wordList[index].word_eng,
                  word_tr: _wordList[index].word_tr,
                  status: _wordList[index].status!);
            },
            itemCount: _wordList.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddWordPage(listID, listName)))
              .then((value) => getWordByList());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple.withOpacity(0.5),
      ),
    );
  }

  InkWell wordItem(int wordID, int index,
      {@required String? word_tr,
      @required String? word_eng,
      @required bool? status}) {
    return InkWell(
      onLongPress: () {
        setState(() {
          pressController = true;
          deleteIndexList[index] = true;
        });
      },
      child: Center(
        child: Container(
          width: double.infinity,
          child: Card(
            color: pressController != true
                ? Color(Methods.HexaColorConverter("#DCD2FF"))
                : Color(Methods.HexaColorConverter("#E7E3F5")),
            elevation: 9,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        word_tr!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "RobotoMedium"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        word_eng!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "RobotoRegular"),
                      ),
                    ),
                  ],
                ),
                pressController != true
                    ? Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.deepPurpleAccent,
                        hoverColor: Colors.blueAccent,
                        value: status,
                        onChanged: (bool? value) {
                          _wordList[index] =
                              _wordList[index].copy(status: value);
                          if (value == true) {
                            toastMessage("Öğrenildi Olarak İşaretlendi.");
                            DB.instance.markAsLearned(
                                true, _wordList[index].id as int);
                          } else {
                            toastMessage("Öğrenilmedi Olarak İşaretlendi.");
                            DB.instance.markAsLearned(
                                false, _wordList[index].id as int);
                          }
                          setState(() {
                            _wordList;
                          });
                        },
                      )
                    : Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.deepPurpleAccent,
                        hoverColor: Colors.blueAccent,
                        value: deleteIndexList[index],
                        onChanged: (bool? value) {
                          setState(() {
                            deleteIndexList[index] = value!;
                            bool deleteProcessController = false;

                            deleteIndexList.forEach((element) {
                              if (element) deleteProcessController = true;
                            });
                            if (!deleteProcessController)
                              pressController = false;
                          });
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
