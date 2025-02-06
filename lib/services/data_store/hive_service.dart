import 'package:hive/hive.dart';
import '../../hive_storage/book_mark_model.dart';

class HiveService {
  Future<Box<BookMarksModel>> openHiveBox(boxbookmark) async {
    // Open the box if it's not already open
    if (!Hive.isBoxOpen(boxbookmark)) {
      await Hive.openBox<BookMarksModel>(boxbookmark);
    }
    return Hive.box<BookMarksModel>(boxbookmark);
  }

  Future<void> closeHiveBox(boxbookmark) async {
    // Close the box if it's open
    if (Hive.isBoxOpen(boxbookmark)) {
      await Hive.box<BookMarksModel>(boxbookmark).close();
    }
  }
}
