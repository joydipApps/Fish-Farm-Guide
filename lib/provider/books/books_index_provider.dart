// book_index_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/books_index_model.dart';
import '../../services/books/book_index_service.dart';

final uniqueGroupNamesProvider = Provider<Set<String>>((ref) => {});

final bookIndexModelProvider =
    StateNotifierProvider<BookIndexModelListNotifier, BookIndexModelList>(
        (ref) {
  return BookIndexModelListNotifier();
});

final bookIndexServiceProvider = Provider<BookIndexService>((ref) {
  return BookIndexService();
});

final bookIndexSuccessProvider =
    StateNotifierProvider<BookIndexSuccessNotifier, bool>((ref) {
  return BookIndexSuccessNotifier(); // You'll need to create this notifier class
});

class BookIndexSuccessNotifier extends StateNotifier<bool> {
  BookIndexSuccessNotifier() : super(false); // Initialize with false

  void setEventSuccess(bool value) {
    state = value;
  }
}
