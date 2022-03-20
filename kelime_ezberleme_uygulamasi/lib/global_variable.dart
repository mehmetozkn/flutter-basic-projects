import 'db/db/db.dart';
import 'db/db/shared_preferences.dart';

enum Lang { eng, tr }
Lang? chooseLang = Lang.eng;

// words_card.dart ve multiple_choice.dart değişkenleri
enum Which { learned, unlearned, all }
enum forWhat { forList, forListMixed }

Which? chooseQuestionType = Which.learned;
bool listMixed = true;

List<Map<String, Object?>> lists = [];
List<bool> selectedIndexList = [];

Future getLists() async {
  Object? value = await SP.read("selected_list");

  lists = await DB.instance.readListAll();
  selectedIndexList = [];
  for (int i = 0; i < lists.length; ++i) {
    bool isThereSame = false;
    if (value != null) {
      for (var element in (value as List)) {
        if (element == lists[i]['lists_id']) {
          isThereSame = true;
        }
      }
    }
    selectedIndexList.add(isThereSame);
  }
}
