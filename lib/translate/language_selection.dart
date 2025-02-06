import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

import '../routes/app_route_constants.dart';
import '../translate/language_store.dart';
import 'package:flutter/material.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker_dropdown.dart';

import '../utils/local_shared_Storage.dart';

void resetRouting(BuildContext context) {
  while (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
  debugPrint('Reset Route');
  GoRouter.of(context).goNamed(AppRouteConstants.homeRouteName);
}

Future<void> showLanguageSelectionDialog(BuildContext context) async {
  final storage = LocalSharedStorage();
  var selectedLanguage = Language.fromIsoCode(await storage.getLanguageCode());

  final supportedLanguages = [
    Languages.bengali, // Add more languages here
    Languages.english, // Add more languages here
    Languages.hindi, // For example, Hindi
  ];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow.shade100,
        shadowColor: Colors.red,
        title: const Text(
          'Select Language',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: LanguagePickerDropdown(
          initialValue: selectedLanguage,
          onValuePicked: (Language pickedLanguage) {
            // Update the selected language when a new one is picked
            selectedLanguage = pickedLanguage;
          },
          languages: supportedLanguages,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await storage.setLanguage(
                languageName: selectedLanguage.name,
                languageCode: selectedLanguage.isoCode,
              );
              // todo reset
              Restart.restartApp();
              // Navigator.of(context).pop(); // original
            },
            child: const Text(
              'Save & Restart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
