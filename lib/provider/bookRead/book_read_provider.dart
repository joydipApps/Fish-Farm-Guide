//book_read_provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/data_store/book_read_manager.dart';

// Define the BookReadManagerProvider, which will provide the BookReadManager
final bookReadManagerProvider = Provider((ref) {
  // final boxService = BoxService(); // You can initialize BoxService here
  return BookReadManager();
});

final readBooksProvider =
    FutureProvider.family<bool, String>((ref, bookId) async {
  final bookReadManager = ref.read(bookReadManagerProvider);
  final readBooks = await bookReadManager.getBooksRead();

  // Assuming `readBooks` is a list of book IDs,
  // and I want to check if the unique key is in this list.
  final isBookRead = readBooks.contains(bookId);

  return isBookRead;
});
