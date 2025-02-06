import 'package:flutter/cupertino.dart';
import 'package:language_picker/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/local_storage/phone_number_provider.dart';
import '../provider/local_storage/phoneno_presence_provider.dart';

class LocalSharedStorage {
  static Future<SharedPreferences> _getInstance() async =>
      await SharedPreferences.getInstance();

  static Future<void> setUser({
    required String phoneNo,
    required String name,
    required String userType,
    PhoneNoNotifier? phoneNoNotifier,
    PhoneNoPresenceNotifier? phoneNoPresenceNotifier,
  }) async {
    if (phoneNo.isNotEmpty && name.isNotEmpty && userType.isNotEmpty) {
      final prefs = await _getInstance();
      final String? storedPhoneNo = prefs.getString('phoneNo');

      if (storedPhoneNo == null) {
        await prefs.setString('phoneNo', phoneNo);
        await prefs.setString('name', name);
        await prefs.setString('userType', userType);
      } else if (storedPhoneNo == phoneNo) {
        await prefs.setString('name', name);
        await prefs.setString('userType', userType);
      } else {
        await prefs.clear();
        await prefs.setString('phoneNo', phoneNo);
        await prefs.setString('name', name);
        await prefs.setString('userType', userType);
      }

      phoneNoNotifier?.setNumber(phoneNo); // Update phone number notifier
      phoneNoPresenceNotifier?.setPresence(true); // Set presence to true
    } else {
      throw Exception('Phone number, name, and user type cannot be blank.');
    }
  }

  static Future<List<String>> getUser() async {
    final prefs = await _getInstance();
    String name = prefs.getString("name") ?? "";
    String phoneNo = prefs.getString("phoneNo") ?? "";
    String userType = prefs.getString("userType") ?? "";
    return [name, phoneNo, userType];
  }

  static Future<void> setName({required String name}) async {
    final prefs = await _getInstance();
    await prefs.setString("name", name);
  }

  static Future<String> getName() async {
    final prefs = await _getInstance();
    String data = prefs.getString("name") ?? "";
    return data;
  }

  static Future<void> setPhoneNo(String phNo) async {
    final prefs = await _getInstance();
    await prefs.setString("phoneNo", phNo);
  }

  static Future<String> getPhoneNo() async {
    final prefs = await _getInstance();
    String data = prefs.getString("phoneNo") ?? "";
    return data;
  }

  static Future<void> setUserType(String userType) async {
    final prefs = await _getInstance();
    await prefs.setString("userType", userType);
  }

  static Future<String> getUserType() async {
    final prefs = await _getInstance();
    String data = prefs.getString("userType") ?? "";
    return data;
  }

  // book app

  Future<void> setLanguage({
    required String languageName,
    required String languageCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existingLanguageCode = prefs.getString('languageCode');

    if (existingLanguageCode == null) {
      // Language preference doesn't exist, create it.
      await prefs.setString('languageName', languageName);
      await prefs.setString('languageCode', languageCode);
    } else if (existingLanguageCode != languageCode) {
      // Language preference exists but is different, update it.
      await prefs.setString('languageName', languageName);
      await prefs.setString('languageCode', languageCode);
    }
  }

  Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString("languageCode");

    if (languageCode != null) {
      return languageCode;
    } else {
      // Log an error or handle the situation where the language code is missing.
      debugPrint("Language code set to bn.");
      return "bn"; // Provide a default language code as a fallback.
    }
  }

  Future<List<String>> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String languageName = prefs.getString("languageName") ?? "null";
    String languageCode = prefs.getString("languageCode") ?? "null";

    if (languageCode == "null") {
      languageCode = "bn";
      languageName = Language.fromIsoCode("bn").name;
    }

    return [languageName, languageCode];
  }
}
