// hive_provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../hive_storage/book_mark_model.dart';
import '../services/data_store/hive_service.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

final openHiveBoxProvider = FutureProvider<Box<BookMarksModel>>((ref) async {
  try {
    debugPrint('Attempting to open Hive box...');
    const boxName = 'boxBookMark';
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<BookMarksModel>(boxName);
    }
    debugPrint('Hive box opened successfully!');
    return Hive.box<BookMarksModel>(boxName);
  } catch (e) {
    debugPrint('Error opening Hive box: $e');
    // Handle the error or rethrow if necessary
    rethrow;
  }
});

final closeHiveProvider = FutureProvider<void>((ref) async {
  try {
    const boxName = 'boxBookMark';
    await Hive.box<BookMarksModel>(boxName).close();
  } catch (e) {
    debugPrint('Error closing Hive box: $e');
    // Handle the error or rethrow if necessary
    rethrow;
  }
});
