// import 'package:flutter/material.dart';
// import 'package:language_picker/languages.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LocalSharedStorage {
//   Future<void> setLanguage({
//     required String languageName,
//     required String languageCode,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     final existingLanguageCode = prefs.getString('languageCode');
//
//     if (existingLanguageCode == null) {
//       // Language preference doesn't exist, create it.
//       await prefs.setString('languageName', languageName);
//       await prefs.setString('languageCode', languageCode);
//     } else if (existingLanguageCode != languageCode) {
//       // Language preference exists but is different, update it.
//       await prefs.setString('languageName', languageName);
//       await prefs.setString('languageCode', languageCode);
//     }
//   }
//
//   Future<String> getLanguageCode() async {
//     final prefs = await SharedPreferences.getInstance();
//     final languageCode = prefs.getString("languageCode");
//
//     if (languageCode != null) {
//       return languageCode;
//     } else {
//       // Log an error or handle the situation where the language code is missing.
//       debugPrint("Language code set to bn.");
//       return "bn"; // Provide a default language code as a fallback.
//     }
//   }
//
//   Future<List<String>> getLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     String languageName = prefs.getString("languageName") ?? "null";
//     String languageCode = prefs.getString("languageCode") ?? "null";
//
//     if (languageCode == "null") {
//       languageCode = "bn";
//       languageName = Language.fromIsoCode("bn").name;
//     }
//
//     return [languageName, languageCode];
//   }
//   // used in the consult section
// }
