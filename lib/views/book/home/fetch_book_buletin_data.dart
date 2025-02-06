import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/books/books_index_provider.dart';
import '../../../provider/bulletin/bulletin_index_provider.dart';
import '../../../provider/welcome_button_provider.dart';
import '../../../utils/show_progress_dialog.dart';

Future<void> fetchBookBulletinData(
  BuildContext context,
  WidgetRef ref,
) async {
  showProgressDialogSync(context);
  try {
    ref.read(loadingStateProvider.notifier).state = true; // Start loading
    // Populate Book Index Data
    // Check if data has already been successfully loaded
    if (!ref.read(bookIndexSuccessProvider)) {
      // If not, fetch data from the server
      final newBookIndex =
          await ref.read(bookIndexServiceProvider).getBookIndexData();

      if (newBookIndex != null) {
        // Assuming addBook method in your notifier takes a BookIndexModelList
        ref.read(bookIndexModelProvider.notifier).addBooks(newBookIndex);

        // Mark the success once data is loaded
        ref.read(bookIndexSuccessProvider.notifier).setEventSuccess(true);
      }
    }

    //  *** Populate Bulletin Index ***
    // Check if data has already been successfully loaded

    if (!ref.read(bulletinIndexSuccessProvider)) {
      // If not, fetch data from the server
      final newBulletinIndex =
          await ref.read(bulletinIndexServiceProvider).getBulletinIndexData();

      if (newBulletinIndex != null) {
        // Assuming addBulletin method in your notifier takes a BulletinIndexModelList
        ref
            .read(bulletinIndexModelProvider.notifier)
            .addBulletinIndexes(newBulletinIndex);

        // Mark the success once data is loaded
        ref.read(bulletinIndexSuccessProvider.notifier).setEventSuccess(true);
      }
    }
  } finally {
    ref.read(loadingStateProvider.notifier).state = false;
    // Stop loading
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
