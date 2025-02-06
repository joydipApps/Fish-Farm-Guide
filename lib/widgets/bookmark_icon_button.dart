// bookmark_icon_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/bookMark/book_mark_notifier.dart';
import '../provider/bookMark/book_mark_provider.dart';

Widget buildBookmarkIconButton(
  BuildContext context,
  String bookId,
  Color kColor,
) {
  return Consumer(
    builder: (context, ref, child) {
      final isBookmarked = ref.watch(bookmarkStateProvider).contains(bookId);

      return IconButton(
        icon: Icon(
          isBookmarked ? Icons.bookmark_added : Icons.bookmark,
          color: isBookmarked ? Colors.lightGreen.shade600 : kColor,
        ),
        iconSize: 22,
        onPressed: () {
          final bookmarkStateNotifier =
              ref.read(bookmarkStateProvider.notifier);
          final bookMarkManager = ref.read(bookMarkManagerProvider);

          if (isBookmarked) {
            // Book is already bookmarked, remove it
            bookmarkStateNotifier.removeBookmark(bookId);
            bookMarkManager.removeBook(bookId);
          } else {
            // Book is not bookmarked, add it
            bookmarkStateNotifier.addBookmark(bookId);
            bookMarkManager.addBookMark(bookId: bookId);
          }

          debugPrint('Bookmark toggled for book ID: $bookId');
        },
      );
    },
  );
}
