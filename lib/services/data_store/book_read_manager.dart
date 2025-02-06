// book_read_manager.dart
import '../../hive_storage/book_mark_model.dart';
import 'box_service.dart';

class BookReadManager {
  final BoxService boxService = BoxService();

  //Future<List<BookMarksModel>> getBooksRead() async {
  Future<List<String>> getBooksRead() async {
    final box = await boxService.openBookmarkBox();
    // Filter the values where isBookRead is true and extract bookIds
    List<String> bookIds = box.values
        .where((bookmark) => bookmark.isBookRead)
        .map((bookmark) => bookmark.bookId)
        .toList();

    return bookIds;
  }

  Future<void> addBookRead({required String bookId}) async {
    final box = await boxService.openBookmarkBox();

    // Use the bookId as the key
    final existingRecord = box.get(bookId);

    if (existingRecord == null) {
      // BookId not present, insert a new record
      await box.put(bookId, BookMarksModel(bookId, true, false));
    } else {
      // BookId present, update the existing record
      existingRecord.isBookRead = true;
      // not updating isBookMark, so it remains as it is.
      await box.put(bookId, existingRecord);
    }
  }
}
