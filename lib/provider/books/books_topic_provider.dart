import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/books_topic_model.dart';
import '../../services/books/book_topic_service.dart';

// Use named constructor for StateNotifierProvider
final bookTopicModelProvider =
    StateNotifierProvider<BookTopicModelNotifier, BookTopicModel?>(
  (ref) => BookTopicModelNotifier(),
);

// Use named constructor for Provider
final bookTopicServiceProvider = Provider<BookTopicService>(
  (ref) => BookTopicService(),
);

// Use named constructor for StateNotifierProvider
final bookTopicSuccessProvider =
    StateNotifierProvider<BookTopicSuccessNotifier, bool>(
  (ref) => BookTopicSuccessNotifier(),
);

class BookTopicSuccessNotifier extends StateNotifier<bool> {
  BookTopicSuccessNotifier() : super(false); // Initialize with false

  void setEventSuccess(bool value) {
    state = value;
  }
}

final isDataFetchedProvider = StateProvider<bool>((ref) => false);

class IsDataFetchedNotifier extends Notifier<bool> {
  void setIsDataFetched(bool value) {
    state = value;
  }

  @override
  bool build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
