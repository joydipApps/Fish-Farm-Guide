import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/bookRead/book_read_provider.dart';

Widget buildReadStatusWidget(String bookId) {
  return Consumer(
    builder: (context, ref, child) {
      final isBookRead = ref.watch(readBooksProvider(bookId));

      return isBookRead.when(
        data: (bool value) {
          return Tooltip(
            preferBelow: false,
            decoration: BoxDecoration(
              color: Colors.yellow.shade100, // Background color
              borderRadius: BorderRadius.circular(10.0),
            ),
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            message: value
                ? 'Already Read\n Apply and Share Wisdom.'
                : 'Yet to Read\n Explore Practical Knowledge.',
            child: Icon(
              value ? Icons.article : Icons.article_outlined,
              color: value ? Colors.teal.shade400 : Colors.red.shade300,
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) {
          // Handle error state as needed
          return Text('Error loading read status: $error');
        },
      );
    },
  );
}
