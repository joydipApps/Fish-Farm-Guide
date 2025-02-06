import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookIndexModel {
  final String bookId;
  final String writerName;
  final String groupName;
  final String languageCode;
  final String languageName;
  final String authorId;
  final String bookName;
  final String bookIntro;
  final int bookImageNos;

  BookIndexModel({
    required this.bookId,
    required this.writerName,
    required this.groupName,
    required this.languageCode,
    required this.languageName,
    required this.authorId,
    required this.bookName,
    required this.bookIntro,
    required this.bookImageNos,
  });

  factory BookIndexModel.fromJson(Map<String, dynamic> json) {
    return BookIndexModel(
      bookId: json['book_id'] ?? "",
      writerName: json['writer_name'] ?? "",
      groupName: json['group_name'] ?? "",
      languageCode: json['language_code'] ?? "",
      languageName: json['language_name'] ?? "",
      authorId: json['author_id'] ?? "0",
      bookName: json['book_name'] ?? "",
      bookIntro: json['book_intro'] ?? "",
      bookImageNos: int.tryParse(json['total_book_image'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_id': bookId,
      'writer_name': writerName,
      'group_name': groupName,
      'language_code': languageCode,
      'language_name': languageName,
      'author_id': authorId,
      'book_name': bookName,
      'book_intro': bookIntro,
      'total_book_image': bookImageNos,
    };
  }
}

class BookIndexModelList {
  final Set<BookIndexModel> books;

  BookIndexModelList({required this.books});
}

class BookIndexModelListNotifier extends StateNotifier<BookIndexModelList> {
  BookIndexModelListNotifier()
      : super(BookIndexModelList(
            books: <BookIndexModel>{})); // Initialize with an empty set

  void updateBookIndexList(BookIndexModelList newBookIndexList) {
    state = newBookIndexList;
  }

  void addBook(BookIndexModel newBookIndex) {
    final updatedBooks = {...state.books, newBookIndex};
    state = BookIndexModelList(books: updatedBooks);
  }

  void addBooks(BookIndexModelList newBooks) {
    final updatedBooks = {...state.books, ...newBooks.books};
    state = BookIndexModelList(books: updatedBooks);
  }

  void removeBook(BookIndexModel bookToRemove) {
    final updatedBooks =
        state.books.where((book) => book != bookToRemove).toSet();
    state = BookIndexModelList(books: updatedBooks);
  }
}
