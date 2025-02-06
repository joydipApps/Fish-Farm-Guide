import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookTopicModel {
  final String bookId;
  final String bookName;
  final String languageCode;
  final String bookDetails;

  BookTopicModel({
    required this.bookId,
    required this.bookName,
    required this.languageCode,
    required this.bookDetails,
  });

  factory BookTopicModel.fromJson(Map<String, dynamic> json) {
    return BookTopicModel(
      bookId: json['book_id'],
      bookName: json['book_name'],
      languageCode: json['language_code'],
      bookDetails: json['book_details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_id': bookId,
      'book_name': bookName,
      'language_code': languageCode,
      'book_details': bookDetails,
    };
  }
}

class BookTopicModelNotifier extends StateNotifier<BookTopicModel?> {
  BookTopicModelNotifier() : super(null);

  void updateBookTopic(BookTopicModel newBookTopic) {
    state = newBookTopic;
  }

  void addBookTopic(
    BookTopicModel bookTopicModel, {
    String? newBookId,
    String? newLanguageCode,
    String? newBookName,
    String? newBookDetails,
  }) {
    final currentModel = state;
    if (currentModel != null) {
      state = BookTopicModel(
        bookId: newBookId ?? currentModel.bookId,
        languageCode: newLanguageCode ?? currentModel.languageCode,
        bookName: newBookName ?? currentModel.bookName,
        bookDetails: newBookDetails ?? currentModel.bookDetails,
      );
    }
  }
}
