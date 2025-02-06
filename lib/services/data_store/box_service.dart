// box_service.dart
import 'package:hive/hive.dart';
import '../../hive_storage/book_mark_model.dart';

class BoxService {
  static const String _bookmarkBoxKey = 'boxbookmark';
  Box<BookMarksModel>? _bookmarkBox;

  Future<Box<BookMarksModel>> openBookmarkBox() async {
    if (Hive.isBoxOpen(_bookmarkBoxKey)) {
      return Hive.box<BookMarksModel>(_bookmarkBoxKey);
    } else {
      return await Hive.openBox<BookMarksModel>(_bookmarkBoxKey);
    }
  }

  Future<void> closeBookmarkBox() async {
    if (_bookmarkBox != null) {
      await _bookmarkBox!.close();
      _bookmarkBox = null; // Reset the box reference
    }
  }
}
