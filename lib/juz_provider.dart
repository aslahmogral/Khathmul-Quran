// import 'package:daily_quran/juz_section/juz_card/juz_card.dart';
import 'package:flutter/material.dart';
import 'package:khathmul_quran/juz_card/juz_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a model class to represent Juz data
class JuzData {
  final double progress;
  final int currentPage;

  JuzData({required this.progress, required this.currentPage});
}

class JuzProgressProvider extends ChangeNotifier {
  late Map<int, JuzData> _globalJuzMap;
  late SharedPreferences _prefs;
  List<JuzCard> juzList = List.generate(
    30,
    (index) => JuzCard(
      juzNumber: index + 1,
    ),
  );
  bool shouldReset = false;

  Map<int, int> totalVerseInJuz = {
  1: 148,
  2: 111,
  3: 126,
  4: 131,
  5: 124,
  6: 110,
  7: 149,
  8: 142,
  9: 159,
  10: 127,
  11: 151,
  12: 170,
  13: 154,
  14: 227,
  15: 185,
  16: 269,
  17: 190,
  18: 202,
  19: 339,
  20: 171,
  21: 178,
  22: 169,
  23: 357,
  24: 175,
  25: 246,
  26: 195,
  27: 399,
  28: 137,
  29: 431,
  30: 564,
};

  void updateShouldReset(bool value) {
    shouldReset = value;
    notifyListeners();
  }

  JuzProgressProvider() {
    _initializeJuzMap();
    _initSharedPreferences();
  }

  void _initializeJuzMap() {
    _globalJuzMap = {
      for (int i = 1; i <= 30; i++) i: JuzData(progress: 0.0, currentPage: 0),
    };
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadJuzProgressFromStorage();
  }

 
  void _saveJuzProgressToStorage(
      int juzNumber, double progress, int currentPage) {
    _prefs.setDouble('juz_$juzNumber' '_progress', progress);
    _prefs.setInt('juz_$juzNumber' '_currentPage', currentPage);
  }

  void _loadJuzProgressFromStorage() {
    for (int i = 1; i <= 30; i++) {
      double progress = _prefs.getDouble('juz_$i' '_progress') ?? 0.0;
      int currentPage = _prefs.getInt('juz_$i' '_currentPage') ?? 0;
      _globalJuzMap[i] = JuzData(progress: progress, currentPage: currentPage);
    }
    notifyListeners();
  }

  void updateJuzProgress(int juzNumber, double progress, int currentPage) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] =
          JuzData(progress: progress, currentPage: currentPage);
      _saveJuzProgressToStorage(juzNumber, progress, currentPage);
      notifyListeners();
    }
  }

  double getJuzProgress(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!.progress
        : 0.0;
  }

  int getJuzCurrentPage(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!.currentPage
        : 0;
  }

  void resetAllJuzProgress() {
    _initializeJuzMap();
    _prefs.clear(); // Clear SharedPreferences to reset the saved data
    notifyListeners();
  }

  void resetSelectedJuzProgress(int juzNumber) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] = JuzData(progress: 0.0, currentPage: 0);
      _saveJuzProgressToStorage(
          juzNumber, 0.0, 0); // Save reset progress to SharedPreferences
          
      notifyListeners();
    }
  }

  void markJuzComplete(int juzNumber) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] =
          JuzData(progress: 100.0, currentPage: totalVerseInJuz[juzNumber]!);
      print('-----------------------------');
      print(totalVerseInJuz[juzNumber]!);
      print('-----------------------------');

      _saveJuzProgressToStorage(juzNumber, 100.0, 0);
      notifyListeners();
    }
  }
}
