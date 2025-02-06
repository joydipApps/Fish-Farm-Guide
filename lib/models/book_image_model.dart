import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookImageModel {
  final int bookImageId;
  final String bookId;
  final String bookImageName;
  final String bookImageBase64;
  final String bookImageDetails;

  BookImageModel({
    required this.bookImageId,
    required this.bookId,
    required this.bookImageName,
    required this.bookImageBase64,
    required this.bookImageDetails,
  });

  factory BookImageModel.fromJson(Map<String, dynamic> json) {
    return BookImageModel(
      bookImageId: int.tryParse(json['book_image_id'].toString()) ?? 0,
      bookId: json['book_id'] ?? "",
      bookImageName: json['book_image_name'] ?? "",
      bookImageBase64: json['book_image_base64'] ?? "",
      bookImageDetails: json['book_image_details'] ?? "",
    );
  }
}

class BookImageModelList {
  final List<BookImageModel> bookImageList;

  BookImageModelList({required this.bookImageList});
}

class BookImageModelListNotifier extends StateNotifier<BookImageModelList> {
  BookImageModelListNotifier()
      : super(BookImageModelList(bookImageList: <BookImageModel>[]));

  void updateBookImage(BookImageModelList newBookImage) {
    state = newBookImage;
  }

  // add one record
  void addBookImageModel(BookImageModel newBookImage) {
    state = BookImageModelList(
        bookImageList: [...state.bookImageList, newBookImage]);
  }

  // add multiple records
  void addBookImageModels(BookImageModelList newLists) {
    state = BookImageModelList(
        bookImageList: [...state.bookImageList, ...newLists.bookImageList]);
  }

  void removeBookImageModel(BookImageModel listToRemove) {
    state = BookImageModelList(
      bookImageList:
          state.bookImageList.where((list) => list != listToRemove).toList(),
    );
  }
}
