import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'book_mark_model.g.dart';

@HiveType(typeId: 0)
class BookMarksModel {
  @HiveField(0)
  String bookId;

  @HiveField(1)
  bool isBookRead;

  @HiveField(2)
  bool isBookMark;

  BookMarksModel(
    this.bookId,
    this.isBookRead,
    this.isBookMark,
  );
}
