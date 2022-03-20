import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kelime_ezberleme_uygulamasi/db/db/db.dart';
import 'package:kelime_ezberleme_uygulamasi/db/db/shared_preferences.dart';
import 'package:kelime_ezberleme_uygulamasi/db/models/words.dart';
import 'package:kelime_ezberleme_uygulamasi/global_variable.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/app_bar.dart';
import 'package:kelime_ezberleme_uygulamasi/global_widget/toast.dart';
import 'package:kelime_ezberleme_uygulamasi/methods.dart';

class MultipleChoicePage extends StatefulWidget {
  const MultipleChoicePage({Key? key}) : super(key: key);

  @override
  _MultipleChoicePage createState() => _MultipleChoicePage();
}

class _MultipleChoicePage extends State<MultipleChoicePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists().then((value) {
      setState(() {
        lists;
      });
    });
  }

  List<Word> _words = [];
  bool start = false;
  List<List<String>> optionsList =
      []; // kelime listesi uzunluğu kadar şık listesi, her şık listedinde 4 şık
  List<String> correctAnswers = [];

  List<bool> clickControl = []; // işaretleme kontrolü
  List<List<bool>> clickControlList =
      []; // hangi şıkkın işaretlendiğinin kontrolü
  int correctCount = 0;
  int wrongCount = 0;

  void getSelectedWordOfLists(List<int> selectedListID) async {
    List<String> value = selectedListID.map((e) => e.toString()).toList();
    SP.write("selected_list", value);
    if (chooseQuestionType == Which.learned) {
      _words = await DB.instance.readWordByLists(selectedListID, status: true);
    } else if (chooseQuestionType == Which.unlearned) {
      _words = await DB.instance.readWordByLists(selectedListID, status: false);
    } else {
      _words = await DB.instance.readWordByLists(selectedListID);
    }

    if (_words.isNotEmpty) {
      if (_words.length > 3) {
        if (listMixed) _words.shuffle();
        Random random = Random();
        for (int i = 0; i < _words.length; ++i) {
          clickControl
              .add(false); // her kelime için cevap verildiğinin kontrolü
          // her kelime için 4 şık var hepsinin işaretlenmediini belirten 4 adet false.
          clickControlList.add([false, false, false, false]);

          List<String> tempOptions = [];
          while (true) {
            int rand = random.nextInt(_words.length);
            if (rand != i) {
              bool isThereSame = false;
              tempOptions.forEach((element) {
                if (chooseLang == Lang.eng) {
                  if (element == _words[rand].word_tr!) isThereSame = true;
                } else {
                  if (element == _words[rand].word_eng!) isThereSame = true;
                }
              });

              if (!isThereSame) {
                tempOptions.add(chooseLang == Lang.eng
                    ? _words[rand].word_tr!
                    : _words[rand].word_eng!);
              }
            }

            if (tempOptions.length == 3) {
              break;
            }
          }
          tempOptions.add(chooseLang == Lang.eng
              ? _words[i].word_tr!
              : _words[i].word_eng!);
          tempOptions.shuffle();
          correctAnswers.add(chooseLang == Lang.eng
              ? _words[i].word_tr!
              : _words[i].word_eng!);
          optionsList.add(tempOptions);
        }

        start = true;
        setState(() {
          start;
          _words;
        });
      } else {
        toastMessage("Minimum 4 Kelime gereklidir.");
      }
    } else {
      toastMessage("Seçilen Şartlarda Liste Boş.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          left: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 28,
          ),
          center: const Text(
            "Çoktan Seçmeli",
            style: TextStyle(
                fontFamily: "carter", color: Colors.black, fontSize: 22),
          ),
          leftWidgetOnClick: () => Navigator.pop(context)),
      body: SafeArea(
        child: start == false
            ? Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
                padding: EdgeInsets.only(left: 4, top: 10, right: 4),
                decoration: BoxDecoration(
                    color: Color(Methods.HexaColorConverter("#DCD2FF")),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whichRadioButton(
                        text: "Öğrenmediklerimi Sor", value: Which.unlearned),
                    whichRadioButton(
                        text: "Öğrendiklerimi Sor", value: Which.learned),
                    whichRadioButton(text: "Hepsini Sor", value: Which.all),
                    checkBox(
                        text: "Listeyi Karıştır", fwhat: forWhat.forListMixed),
                    SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Listeler",
                        style: const TextStyle(
                            fontFamily: "RobotoRegular",
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 16, top: 10),
                      height: 200,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                      child: Scrollbar(
                        thickness: 5,
                        isAlwaysShown: true,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return checkBox(
                                index: index,
                                text: lists[index]['name'].toString());
                          },
                          itemCount: lists.length,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          List<int> selectedIndexNoOfList = [];
                          for (int i = 0; i < selectedIndexList.length; ++i) {
                            if (selectedIndexList[i] == true) {
                              selectedIndexNoOfList.add(i);
                            }
                          }

                          List<int> selectedListIdList = [];
                          for (int i = 0;
                              i < selectedIndexNoOfList.length;
                              ++i) {
                            selectedListIdList.add(
                                lists[selectedIndexNoOfList[i]]['list_id']
                                    as int);
                          }

                          if (selectedListIdList.isNotEmpty) {
                            getSelectedWordOfLists(selectedListIdList);
                          } else {
                            toastMessage("Lütfen Liste Seçin.");
                          }
                        },
                        child: Text(
                          "Başla",
                          style: TextStyle(
                              fontFamily: "RobotoRegular",
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : CarouselSlider.builder(
                options: CarouselOptions(
                  height: double.infinity,
                ),
                itemCount: _words.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 10),
                              padding:
                                  EdgeInsets.only(left: 4, top: 10, right: 4),
                              decoration: BoxDecoration(
                                  color: Color(
                                      Methods.HexaColorConverter("#DCD2FF")),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (chooseLang == Lang.eng
                                        ? _words[itemIndex].word_eng!
                                        : _words[itemIndex].word_tr!),
                                    style: TextStyle(
                                        fontFamily: "RobotoRegular",
                                        fontSize: 28,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  customRadioButtonList(
                                      itemIndex,
                                      optionsList[itemIndex],
                                      correctAnswers[itemIndex]),
                                ],
                              ),
                            ),
                            Positioned(
                              child: Text(
                                (itemIndex + 1).toString() +
                                    "/" +
                                    (_words.length).toString(),
                                style: TextStyle(
                                    fontFamily: "RobotoRegular",
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              left: 30,
                              top: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: CheckboxListTile(
                          title: Text("Öğrendim"),
                          value: _words[itemIndex].status,
                          onChanged: (value) {
                            _words[itemIndex] =
                                _words[itemIndex].copy(status: value);
                            DB.instance.markAsLearned(
                                value!, _words[itemIndex].id as int);
                            toastMessage(value
                                ? "Öğrenildi Olarak İşaretlendi."
                                : "Öğrenilmedi Olarak İşaretlendi!");
                            setState(() {
                              _words[itemIndex];
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }),
      ),
    );
  }

  SizedBox whichRadioButton({@required String? text, @required Which? value}) {
    return SizedBox(
      width: 275,
      height: 30,
      child: ListTile(
        title: Text(
          text!,
          style: const TextStyle(fontFamily: "RobotoRegular", fontSize: 18),
        ),
        leading: Radio<Which>(
          value: value!,
          groupValue: chooseQuestionType,
          onChanged: (Which? value) {
            chooseQuestionType = value;
            setState(() {
              chooseQuestionType;
            });
            switch (value) {
              case Which.learned:
                SP.write("which", 0);
                break;

              case Which.unlearned:
                SP.write("which", 1);
                break;

              case Which.all:
                SP.write("which", 2);
                break;

              default:
                break;
            }
          },
        ),
      ),
    );
  }

  SizedBox checkBox(
      {int index = 0, String? text, forWhat fwhat = forWhat.forList}) {
    return SizedBox(
      width: 270,
      height: 25,
      child: ListTile(
        title: Text(
          text!,
          style: TextStyle(fontFamily: "RobotoRegular", fontSize: 18),
        ),
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.deepPurpleAccent,
          hoverColor: Colors.blueAccent,
          value:
              fwhat == forWhat.forList ? selectedIndexList[index] : listMixed,
          onChanged: (bool? value) {
            setState(() {
              if (fwhat == forWhat.forList) {
                selectedIndexList[index] = value!;
              } else {
                listMixed = value!;
                SP.write("mix", value);
              }
            });
          },
        ),
      ),
    );
  }

  Container customRadioButton(int index, List<String> options, int order) {
    Icon uncheck = const Icon(
      Icons.radio_button_off_outlined,
      size: 16,
    );
    Icon check = const Icon(
      Icons.radio_button_checked,
      size: 16,
    );
    return Container(
      margin: const EdgeInsets.all(4),
      child: Row(
        children: [
          clickControlList[index][order] == false ? uncheck : check,
          const SizedBox(
            width: 10,
          ),
          Text(
            options[order],
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Column customRadioButtonList(
      int index, List<String> options, String correctAnswers) {
    Divider divider = const Divider(
      thickness: 1,
      height: 1,
    );
    return Column(
      children: [
        divider,
        InkWell(
          onTap: () => toastMessage("Seçmek için çift tiklayin."),
          onDoubleTap: () => checker(index, 0, options, correctAnswers),
          child: customRadioButton(index, options, 0),
        ),
        divider,
        InkWell(
          onTap: () => toastMessage("Seçmek için çift tiklayin."),
          onDoubleTap: () => checker(index, 1, options, correctAnswers),
          child: customRadioButton(index, options, 1),
        ),
        divider,
        InkWell(
          onTap: () => toastMessage("Seçmek için çift tiklayin."),
          onDoubleTap: () => checker(index, 2, options, correctAnswers),
          child: customRadioButton(index, options, 2),
        ),
        divider,
        InkWell(
          onTap: () => toastMessage("Seçmek için çift tiklayin."),
          onDoubleTap: () => checker(index, 3, options, correctAnswers),
          child: customRadioButton(index, options, 3),
        ),
        divider,
      ],
    );
  }

  void checker(int index, int order, options, correctAnswers) {
    if (clickControl[index] == false) {
      clickControl[index] = true;
      setState(() => clickControlList[index][order] = true);

      if (options[order] == correctAnswers) {
        correctCount++;
      } else {
        wrongCount++;
      }

      if ((correctCount) + (wrongCount) == _words.length) {
        toastMessage("Test Bitti.");
      }
    }
  }
}
