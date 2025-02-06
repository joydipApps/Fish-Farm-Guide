// book_mark_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'book_mark_provider.dart';

final bookmarkedBookIdsProvider = FutureProvider<List<String>>(
  (ref) => ref.read(bookMarkManagerProvider).getBookmarkedBookIds(),
);

final bookmarkStateProvider =
    StateNotifierProvider<BookmarkStateNotifier, List<String>>(
  (ref) => BookmarkStateNotifier(
    ref.watch(bookmarkedBookIdsProvider).maybeWhen(
          data: (data) => data,
          orElse: () =>
              [], // Provide a default value if data is not available yet
        ),
  ),
);

class BookmarkStateNotifier extends StateNotifier<List<String>> {
  BookmarkStateNotifier(super.initialBookmarkedBookIds);

  // Method to add a book to bookmarks
  void addBookmark(String bookId) {
    final newState = state.toList();
    if (!newState.contains(bookId)) {
      newState.add(bookId);
      state = newState;
    }
  }

  // Method to remove a book from bookmarks
  void removeBookmark(String bookId) {
    final newState = state.toList();
    newState.remove(bookId);
    state = newState;
  }
}
