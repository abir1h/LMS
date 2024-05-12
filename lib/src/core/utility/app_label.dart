import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common_widgets/custom_toasty.dart';

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
    'january': 'জানুয়ারি',
    'february': 'ফেব্রুয়ারি',
    'march': 'মার্চ',
    'april': 'এপ্রিল',
    'may': 'মে',
    'june': 'জুন',
    'july': 'জুলাই',
    'august': 'আগস্ট',
    'september': 'সেপ্টেম্বর',
    'october': 'অক্টোবর',
    'november': 'নভেম্বর',
    'december': 'ডিসেম্বর',
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
    'am': 'এম',
    'pm': 'পিএম',
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
  print(banglaText);

  return banglaText;
}

Future<void> downloadFiles(
    {required String fileUrl,
    required String filename,
    required BuildContext context}) async {
  final deviceInfo = await DeviceInfoPlugin().androidInfo;

  if (deviceInfo.version.sdkInt > 32) {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      // Proceed with the file download
      downloadFile(url: fileUrl, filename: filename, context: context);
    } else {
      // Permission denied

      CustomToasty.of(context).showSuccess('Storage permission denied');
    }
  } else {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Proceed with the file download
      downloadFile(url: fileUrl, filename: filename, context: context);
    } else {
      // Permission denied
      CustomToasty.of(context).showSuccess('Storage permission denied');
    }
  }
}

Future<void> downloadFile({
  required String url,
  required String filename,
  required BuildContext context,
}) async {
  try {
    HttpClient client = HttpClient();
    List<int> downloadData = [];

    Directory? downloadDirectory;

    if (Platform.isIOS) {
      downloadDirectory = await getApplicationDocumentsDirectory();
    } else {
      downloadDirectory = Directory('/storage/emulated/0/Download');
      if (!await downloadDirectory.exists()) {
        downloadDirectory = (await getExternalStorageDirectory());
      }
    }

    String filePathName = "${downloadDirectory?.path}/$filename";
    File savedFile = File(filePathName);
    bool fileExists = await savedFile.exists();

    if (fileExists && context.mounted) {
      CustomToasty.of(context).showSuccess("File already downloaded");
    } else {
      client.getUrl(Uri.parse(url)).then(
        (HttpClientRequest request) {
          CustomToasty.of(context).showSuccess("Downloading file...");
          return request.close();
        },
      ).then(
        (HttpClientResponse response) {
          response.listen((d) => downloadData.addAll(d), onDone: () {
            savedFile.writeAsBytes(downloadData);
            CustomToasty.of(context)
                .showSuccess("File downloaded successfully");
          });
        },
      );
    }
  } catch (error) {
    CustomToasty.of(context).showSuccess("Some error occurred -> $error");
  }
}
