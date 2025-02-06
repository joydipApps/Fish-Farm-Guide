//book_mark_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../hive_storage/book_mark_model.dart';
import '../../models/books_index_model.dart';
import '../../services/data_store/book_mark_manager.dart';
import '../../services/data_store/box_service.dart';
import '../books/books_index_provider.dart';
import 'book_mark_notifier.dart';

// Define the BookReadManagerProvider, which will provide the BookReadManager
final bookMarkManagerProvider = Provider((ref) {
  // final boxService = BoxService(); // You can initialize BoxService here
  return BookMarkManager();
});

// gives the list of book marks new provider
// Provider for the data from the Hive box (fetches data for all book IDs)
final allBookmarksDataProvider =
    FutureProvider<List<BookMarksModel>>((ref) async {
  final boxService = BoxService();
  // Fetch data for all book IDs
  final allData = await boxService.openBookmarkBox(
      /* specify a common book ID for all bookmarks */);
  return allData.values.toList();
});

// Provider to filter the bookmarks where isBookMark is true for a specific bookId
final bookMarksProvider = ProviderFamily<List<String>, String>((ref, bookId) {
  final allData = ref.watch(allBookmarksDataProvider).maybeWhen(
        data: (data) => data,
        orElse: () => <BookMarksModel>[],
      );
  final filteredBookIds = allData
      .where((bookmark) => bookmark.isBookMark && bookmark.bookId == bookId)
      .map((bookmark) => bookmark.bookId)
      .toList();
  return filteredBookIds;
});

final bookMarkStateProvider =
    StateProviderFamily<StateController<bool>, String>((ref, bookId) {
  return StateController<bool>(
      false); // Initialize state to false for each bookId
});

// new common books
final commonBooksProvider = FutureProvider<List<BookIndexModel>>(
  (ref) async {
    final existingModelList = ref.read(bookIndexModelProvider).books.toList();
    final bookmarkedBookIds = ref.watch(bookmarkedBookIdsProvider).maybeWhen(
          data: (data) => data,
          orElse: () =>
              <String>[], // Provide a default empty list if data is not available yet
        );

    // Filter the existingModelList to return BookIndexModel objects with common book IDs
    final commonBooks = existingModelList
        .where((book) => bookmarkedBookIds.contains(book.bookId))
        .toList();

    return commonBooks;
  },
);
