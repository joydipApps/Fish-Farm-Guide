import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/book_image_model.dart';
import '../../services/books/book_image_service.dart';

/*
for every bookId there will be multiple bookImageId
we will fetch data from api calling bookId
the api always provide a list of data
the model provider will maintain the uniqueness of in the model data with bookId+bookImageId
If the model contains data of a particular bookId it will be not be fetched from the server
*/

final selectedBookImageIdProvider = StateProvider<int>((ref) => 0);

final bookImageModelProvider =
    StateNotifierProvider<BookImageModelListNotifier, BookImageModelList>(
  (_) => BookImageModelListNotifier(),
);

final bookImageServiceProvider =
    Provider<BookImageService>((ref) => BookImageService());

final bookImageSuccessProvider =
    StateNotifierProvider<BookImageSuccessNotifier, Map<String, bool>>(
  (_) => BookImageSuccessNotifier(),
);

class BookImageSuccessNotifier extends StateNotifier<Map<String, bool>> {
  BookImageSuccessNotifier() : super({});

  // Getter to access the state
  Map<String, bool> get successMap => state;

  // Setter to modify the state
  set successMap(Map<String, bool> newState) {
    state = newState;
  }

  // Set the success status for a specific bookId.
  void setEventSuccess(String bookId, bool value) {
    successMap = {...successMap, bookId: value};
  }

// Set the success status for a specific bookId or bookId-bookImageId combination.
//   void setEventSuccess(String bookId, int? bookImageId, bool value) {
//     if (bookImageId != null) {
//       // Set success for a specific bookId-bookImageId combination
//       successMap = {...successMap, '$bookId-$bookImageId': value};
//     } else {
//       // Set success for a specific bookId
//       successMap = {...successMap, bookId: value};
//     }
//   }
}

// class BookImageSuccessNotifier extends StateNotifier<Map<String, bool>> {
//   BookImageSuccessNotifier() : super({});
//
//   void setEventSuccess(String bookId, bool value) {
//     state = {...state, bookId: value};
//   }
// }
