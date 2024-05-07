import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

///App Language
enum AppLanguage { english, bangla }

String label({required String e, required String b}) {
  return App.currentAppLanguage == AppLanguage.english
      ? (e.isNotEmpty ? e : b)
      : (b.isNotEmpty ? b : e);
}

class App {
  App._();
  static App? _app;
  static App get instance => _app ?? (_app = App._());

  //App Language
  static AppLanguage _appLanguage = AppLanguage.bangla;
  static AppLanguage get currentAppLanguage => _appLanguage;

  ///Set current language
  static Future<bool> setAppLanguage(int index) async {
    Completer<bool> completer = Completer();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("appLanguage", index).then((x) async {
        _appLanguage = index == 1 ? AppLanguage.english : AppLanguage.bangla;
        completer.complete(true);
        await getCurrentLanguage();
      }).catchError((x) {
        completer.completeError("Not storred !");
      });
    } catch (e) {
      completer.completeError("Not storred !");
    }
    return completer.future;
  }

  ///Get current language
  static Future<AppLanguage> getCurrentLanguage() async {
    Completer<AppLanguage> completer = Completer();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? index = prefs.getInt("appLanguage");
      AppLanguage language =
          index == 1 ? AppLanguage.english : AppLanguage.bangla;
      _appLanguage = language;
      completer.complete(language);
    } catch (e) {
      //print(e);
      completer.complete(AppLanguage.bangla);
    }
    return completer.future;
  }
}

String replaceEnglishNumberWithBengali(String inputString) {
  Map<String, String> numberMap = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  String result = '';
  for (int i = 0; i < inputString.length; i++) {
    String char = inputString[i];
    String replacement = numberMap[char] ?? char;
    result += replacement;
  }

  return result;
}

String timeAgoToBengali(String timeAgo) {
  // Define a map to store the mapping of English words to Bangla words
  final Map<String, String> banglaMap = {
    'January': 'জানুয়ারি',
    'February': 'ফেব্রুয়ারি',
    'March': 'মার্চ',
    'April': 'এপ্রিল',
    'May': 'মে',
    'June': 'জুন',
    'July': 'জুলাই',
    'August': 'আগস্ট',
    'September': 'সেপ্টেম্বর',
    'october': 'অক্টোবর',
    'November': 'নভেম্বর',
    'December': 'ডিসেম্বর',
    'seconds': 'সেকেন্ড',
    'minute': 'মিনিট',
    'minutes': 'মিনিট',
    'hour': 'ঘন্টা',
    'hours': 'ঘন্টা',
    'day': 'দিন',
    'days': 'দিন',
    'week': 'সপ্তাহ',
    'weeks': 'সপ্তাহ',
    'month': 'মাস',
    'months': 'মাস',
    'year': 'বছর',
    'years': 'বছর',
    'ago': 'আগে',
    'moment': 'কিছুক্ষণ',
    'about': 'প্রায়',
    'an': 'এক',
    'a': '',
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  // Split the timeAgo string into words
  List<String> words = timeAgo.split(' ');

  // Replace English words with Bangla words using the map
  String banglaText = words.map((word) {
    // Check if the word is a number
    if (int.tryParse(word) != null) {
      // Convert each digit separately
      return word.split('').map((char) => banglaMap[char] ?? char).join('');
    }
    return banglaMap[word.toLowerCase()] ?? word;
  }).join(' ');

  return banglaText;
}
