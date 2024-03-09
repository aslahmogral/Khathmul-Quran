// import 'package:daily_quran/juz_section/juz_screen/juz_screen.dart';
// import 'package:daily_quran/references/screens/surah_screen/surah_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:khathmul_quran/juz_screen/juz_screen.dart';

class juzCardModel with ChangeNotifier {
  String status = 'Read';
  var currentAyah = 0;
  late Box box;
  // late Box surahbox;
  late int juzNumber;
  // late String boxName;
  bool isResetCheck = false;
  bool isMarkCompletedCheck = false;

  juzCardModel(
    int surahNumber,
  ) {
    this.juzNumber = surahNumber;
    // this.boxName = boxName;
    // initBox(surahNumber);
  }
  void resetJuzCheckMethod(bool value) {
    isResetCheck = value;
    if (value) {
      isMarkCompletedCheck = false;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  void markCompletedCheck(bool value) {
    isMarkCompletedCheck = value;
    if (value) {
      isResetCheck = false;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  Future<void> onListTileClicked(
      BuildContext context, juzCardModel model) async {
    // var result = await
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JuzScreen(
            juzNumber: juzNumber,
          ),
        ));

    notifyListeners();
  }
}
