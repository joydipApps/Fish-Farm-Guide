// Modify buildPageIndicator to accept ref parameter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/bulletin/current_page_provider.dart';

Widget buildPageIndicator(int index, WidgetRef ref, bool static) {
  print('Building Page Indicator for Index: $index');
  int currentPage =
      ref.watch(currentPageProvider); // Use watch to get the current value

  Color dotColor = static
      ? Colors.blue.shade900
      : currentPage == index
          ? Colors.blue.shade900
          : Colors.blue.shade900.withOpacity(0.5);

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2.0),
    height: 8.0,
    width: 8.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: dotColor,
    ),
  );
}
