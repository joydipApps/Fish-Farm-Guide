// main.dart - checked
import 'package:path_provider/path_provider.dart';

import 'routes/app_route_config.dart';
import 'themes/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:path_provider/path_provider.dart';
import 'hive_storage/book_mark_model.dart';
import 'package:in_app_update/in_app_update.dart';

// ignore: unused_import
import 'provider/all_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //debugPaintSizeEnabled = true;
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.initFlutter();
  Hive.registerAdapter(BookMarksModelAdapter());

  if (!Hive.isBoxOpen('boxbookmark')) {
    debugPrint('1 From Main Opening Hive db');
    await Hive.openBox<BookMarksModel>('boxbookmark');
  } else {
    debugPrint('2 From Main *** Hive db already open');
    // return;
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();

      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate();
      } else if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateNotAvailable) {
        debugPrint(
            'No update available at the moment. Your app is up to date.');
      } else {
        debugPrint(
            'Unexpected update availability status: ${appUpdateInfo.updateAvailability}');
      }
    } catch (e) {
      debugPrint('Error checking for update: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fish Farm Guide',
      routerConfig: MyAppRouteConfig().router,
      theme: ThemeData.light().copyWith(
        colorScheme: CustomAppTheme.themeData.colorScheme,
        textTheme: CustomAppTheme.themeData.textTheme,
      ),
    );
  }
}
