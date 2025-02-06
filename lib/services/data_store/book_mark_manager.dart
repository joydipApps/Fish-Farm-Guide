// book_mark_manager.dart

import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../hive_storage/book_mark_model.dart';
import 'box_service.dart';

class BookMarkManager {
  final BoxService boxService = BoxService();
  late Box<BookMarksModel> bookmarksBox;
  // stream controller for new records
  final _bookmarksController = StreamController<List<BookMarksModel>>();
  Stream<List<BookMarksModel>> get bookmarksStream =>
      _bookmarksController.stream;

  Future<void> openBookmarkBox() async {
    bookmarksBox = await boxService.openBookmarkBox();

    // Add a listener to the bookmarksBox
    bookmarksBox.listenable().addListener(() {
      // Handle the event (e.g., update  UI)
      _bookmarksController.add(bookmarksBox.values.toList());
      debugPrint('Bookmarks updated: ${bookmarksBox.values.toList()}');
    });
  }

  Future<List<String>> getBookmarkedBookIds() async {
    final box = await boxService.openBookmarkBox();
    final bookmarks =
        box.values.where((bookmark) => bookmark.isBookMark).toList();
    final bookmarkedBookIds =
        bookmarks.map((bookmark) => bookmark.bookId).toList();
    return bookmarkedBookIds;
  }

  Future<List<BookMarksModel>> getBooksMarked() async {
    final box = await boxService.openBookmarkBox();
    // Directly filter the values where isBookMark is true
    return box.values.where((bookmark) => bookmark.isBookMark).toList();
  }

  Future<void> addBookMark({
    required String bookId,
  }) async {
    try {
      final box = await boxService.openBookmarkBox();
      final existingRecord = box.get(bookId);

      if (existingRecord == null) {
        await box.put(bookId, BookMarksModel(bookId, false, true));
      } else {
        existingRecord.isBookMark = true;
        await box.put(bookId, existingRecord);
      }
      // Add this line to update the StreamController
      _bookmarksController.add(box.values.toList());
    } catch (e) {
      debugPrint("Error while adding bookmark: $e");
    }
  }

  Future<void> removeBook(String bookId) async {
    try {
      final box = await boxService.openBookmarkBox();
      final existingRecord = box.get(bookId);

      if (existingRecord != null && existingRecord.isBookMark) {
        existingRecord.isBookMark = false;
        await box.put(bookId, existingRecord);
      }
    } catch (e) {
      // Handle and log the error, or display a user-friendly message.
      debugPrint("Error while removing bookmark: $e");
      // Optionally, rethrow the error to propagate it.
      // rethrow;
    }
  }
}
