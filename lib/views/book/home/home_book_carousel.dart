import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/bulletin_list_model.dart';
import '../../../provider/bulletin/bulletin_index_provider.dart';
import '../../../provider/bulletin/bulletin_list_provider.dart';
import '../../../provider/bulletin/current_page_provider.dart';
import '../../../themes/custom_app_theme.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_methods.dart';

class HomeBookCarouselPage extends ConsumerWidget {
  const HomeBookCarouselPage({
    super.key,
    required this.book_id,
  });
  final String book_id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int bulletinIndexId = ref.read(selectedBulletinIndexIdProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    const double aspectRatio = 16 / 9; // 16:9 aspect ratio
    final double imageHeight = screenWidth / aspectRatio;
    final PageController pageController = PageController();

    final List<BulletinListModel> bulletinList = ref
        .watch(bulletinListModelProvider)
        .bulletinList
        .where((bulletin) => bulletin.bulletinIndexId == bulletinIndexId)
        .toList();

    return Theme(
      data: CustomAppTheme.themeData
          .copyWith(cardTheme: CustomAppTheme.themeData.cardTheme),
      child: Scaffold(
        appBar: commonAppBar(
          context,
          'Bulletin Slider',
          isIconBack: true,
          showBottomTabBar: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: bulletinList.length,
                itemBuilder: (context, index) {
                  final BulletinListModel bulletinData = bulletinList[index];
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bulletinData.bulletinHeader,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
                                base64Decode(bulletinData.bulletinImageBase64),
                                width: screenWidth,
                                height: imageHeight,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              formatBulletinDate(bulletinData.bulletinDate),
                              style: const TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            bulletinData.bulletinText,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            visible: bulletinData.bulletinUrl.isNotEmpty,
                            child: ElevatedButton(
                              onPressed: () =>
                                  launchURL(bulletinData.bulletinUrl),
                              style: ElevatedButton.styleFrom(
                                elevation: 10.0,
                                shadowColor: Colors.yellowAccent,
                                backgroundColor: Colors.yellow.shade100,
                              ),
                              child: const Text(
                                "Associated Article / Website",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                onPageChanged: (int page) {
                  ref
                      .read(currentPageProvider.notifier)
                      .updateCurrentPage(page);
                },
              ),
            ),
            // Add colored dots as indicators
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  bulletinList.length,
                  (index) => buildPageIndicator(index, ref),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modify buildPageIndicator to accept ref parameter
  Widget buildPageIndicator(int index, WidgetRef ref) {
    int currentPage =
        ref.watch(currentPageProvider); // Use watch to get the current value

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index
            ? Colors.amberAccent
            : Colors.amberAccent.withOpacity(0.5),
      ),
    );
  }
}
