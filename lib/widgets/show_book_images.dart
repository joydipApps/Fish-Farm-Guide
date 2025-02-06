import 'dart:convert';

import '/widgets/build_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/book_image_model.dart';
import '../provider/books/books_image_provider.dart';
import '../provider/bulletin/current_page_provider.dart';

Future<void> showCarouselDialog(
    BuildContext context, String bookId, WidgetRef ref) async {
  final provider = ref.read(bookImageModelProvider);

  final List<BookImageModel> filteredBookImages =
      provider.bookImageList.where((image) => image.bookId == bookId).toList();

  final double screenWidth = MediaQuery.of(context).size.width;
  const double aspectRatio = 1; // 16:9 aspect ratio
  final double screenHeight = screenWidth / aspectRatio;
  final PageController pageController = PageController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow.shade100,
        contentPadding: const EdgeInsets.all(5),
        shadowColor: Colors.red,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: screenHeight,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: filteredBookImages.length,
                  itemBuilder: (context, index) {
                    final base64Image =
                        filteredBookImages[index].bookImageBase64;
                    final imageName = filteredBookImages[index].bookImageName;
                    final imageDetails =
                        filteredBookImages[index].bookImageDetails;

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              imageName,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                              child: FittedBox(
                                child: Image.memory(
                                  base64Decode(base64Image),
                                  height: screenHeight,
                                  width: screenWidth,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              imageDetails,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    );
                  },
                  onPageChanged: (int page) {
                    debugPrint('Current Page on change: $page');
                    ref
                        .read(currentPageProvider.notifier)
                        .updateCurrentPage(page);
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10.0,
                  shadowColor: Colors.yellowAccent,
                  backgroundColor:
                      Colors.yellow.shade100, // Set the button color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.green.shade900, // Set the icon color
                    ),
                    const SizedBox(width: 5),
                    // Adjust the spacing between icon and text
                    Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green.shade900, // Set the text color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    filteredBookImages.length,
                    (index) => buildPageIndicator(index, ref, true),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
