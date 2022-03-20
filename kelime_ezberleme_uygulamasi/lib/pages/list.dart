import 'package:flutter/material.dart';
import 'package:kelime_ezberleme_uygulamasi/db/db/db.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/app_bar.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/toast.dart';
import 'package:kelime_ezberleme_uygulamasi/methods.dart';
import 'package:kelime_ezberleme_uygulamasi/pages/words.dart';

import 'create_list.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<Map<String, Object?>> _lists = [];
  bool pressController = false;
  List<bool> deleteIndexList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getList() async {
    _lists = await DB.instance.readListAll();
    for (int i = 0; i < _lists.length; ++i) {
      deleteIndexList.add(false);
    }
    setState(() {
      _lists;
    });
  }

  void delete() async {
    List<int> removeIndexList = [];
    for (int i = 0; i < _lists.length; ++i)
      if (deleteIndexList[i] == true) removeIndexList.add(i);

    for (int i = removeIndexList.length - 1; i >= 0; --i) {
      DB.instance.deleteListsAndWordByList(
          _lists[removeIndexList[i]]['list_id'] as int);
      _lists.removeAt(removeIndexList[i]);
      deleteIndexList.removeAt(removeIndexList[i]);
    }

    for (int i = 0; i < deleteIndexList.length; ++i) deleteIndexList[i] = false;

    setState(() {
      _lists;
      deleteIndexList;
      pressController = false;
    });
    toastMessage("Seçili Listeler Başarıyla Silindi.");
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
          center: Image.asset('assets/images/lists.png'),
          right: pressController != true
              ? Image.asset(
                  'assets/images/logo.png',
                  height: 35,
                  width: 35,
                )
              : InkWell(
                  onTap: delete,
                  child: Icon(
                    Icons.delete,
                    color: Colors.deepPurpleAccent,
                    size: 24,
                  ),
                ),
          leftWidgetOnClick: () => Navigator.pop(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateList()))
                .then((value) => getList());
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple.withOpacity(0.5),
        ),
        body: SafeArea(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return listItem(_lists[index]['list_id'] as int, index,
                listName: _lists[index]['name'].toString(),
                sumWords: _lists[index]['sum_word'].toString(),
                sumUnlearned: _lists[index]['sum_unlearned'].toString());
          },
          itemCount: _lists.length,
        )));
  }

  InkWell listItem(int id, int index,
      {@required String? listName,
      @required String? sumWords,
      @required String? sumUnlearned}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WordsPage(id, listName))).then((value) {
          getList();
        });
      },
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
            color: Color(Methods.HexaColorConverter("#DCD2FF")),
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
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        listName!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "RobotoMedium"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        sumWords! + " Terim",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "RobotoRegular"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        (int.parse(sumWords) - int.parse(sumUnlearned!))
                                .toString() +
                            " Öğrenildi.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "RobotoRegular"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, bottom: 5),
                      child: Text(
                        sumUnlearned + " Öğrenilmedi.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "RobotoRegular"),
                      ),
                    ),
                  ],
                ),
                pressController == true
                    ? Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.deepPurpleAccent,
                        hoverColor: Colors.blueAccent,
                        value: deleteIndexList[index],
                        onChanged: (bool? value) {
                          setState(() {
                            deleteIndexList[index] = value!;
                            bool deleteProcessController = false;
                            deleteIndexList.forEach((element) {
                              if (element == true)
                                deleteProcessController = true;
                            });
                            if (!deleteProcessController)
                              pressController = false;
                          });
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
