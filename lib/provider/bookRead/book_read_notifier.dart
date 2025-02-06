// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'book_read_provider.dart';
//
// final readBooksStateNotifierProvider =
//     StateNotifierProvider<ReadBooksStateNotifier, AsyncValue<List<String>>>(
//         (ref) {
//   return ReadBooksStateNotifier(
//       AsyncValue.data([])); // Initialize with an empty list
// });
//
// class ReadBooksStateNotifier extends StateNotifier<AsyncValue<List<String>>> {
//   ReadBooksStateNotifier(AsyncValue<List<String>> initialState)
//       : super(initialState);
//
//   void markAsRead(String bookId) {
//     state = state.when(
//       data: (currentData) {
//         if (!currentData.contains(bookId)) {
//           final newData = [...currentData, bookId];
//           return AsyncValue.data(newData);
//         }
//         return state; // Book is already marked as read, no change.
//       },
//       loading: () => state, // Keep the loading state as is.
//       error: (error, stackTrace) => state, // Keep the error state as is.
//     );
//   }
// }
