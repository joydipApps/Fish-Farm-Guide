// // todo delete
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class BookmarkToggleStateNotifier extends StateNotifier<bool> {
//   BookmarkToggleStateNotifier(bool initialState) : super(initialState);
//
//   void updateState(bool newState) {
//     state = newState;
//   }
//
//   void toggle() {
//     state = !state;
//   }
// }
//
// final isBookmarkedProviderFamily =
//     StateNotifierProviderFamily<BookmarkToggleStateNotifier, bool, String>(
//   (ref, bookId) {
//     return BookmarkToggleStateNotifier(false);
//   },
// );
