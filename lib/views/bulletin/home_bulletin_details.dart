import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/bulletin_list_model.dart';
import '../../provider/bulletin/bulletin_list_provider.dart';
import '../../routes/app_route_constants.dart';
import '../../themes/custom_app_theme.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_methods.dart';

class HomeBulletinDetailsPage extends ConsumerWidget {
  const HomeBulletinDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int bulletinId = ref.read(selectedBulletinIdProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    const double aspectRatio = 16 / 9; // 16:9 aspect ratio
    final double imageHeight = screenWidth / aspectRatio;
    // Find the specific bulletin with the matching bulletinId
    final BulletinListModel bulletinData =
        ref.watch(bulletinListModelProvider).bulletinList.firstWhere(
              (bulletin) => bulletin.bulletinId == bulletinId,
            );

    return Theme(
      data: CustomAppTheme.themeData
          .copyWith(cardTheme: CustomAppTheme.themeData.cardTheme),
      child: Scaffold(
        appBar: commonAppBar(context, 'Bulletin Details',
            isIconBack: true, showBottomTabBar: false),
        body: SingleChildScrollView(
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bulletinData.bulletinHeader,
                        textAlign: TextAlign.justify,
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
                          onPressed: () => launchURL(bulletinData.bulletinUrl),
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
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              GoRouter.of(context).goNamed(AppRouteConstants.homeRouteName);
              // Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              elevation: 10.0,
              shadowColor: Colors.yellowAccent,
              backgroundColor: Colors.yellow.shade100, // Set the button color
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
