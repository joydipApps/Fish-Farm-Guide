import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/bulletin_index_model.dart';
import '../../provider/bulletin/bulletin_index_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../provider/bulletin/bulletin_list_provider.dart';
import '../../routes/app_route_constants.dart';
import '../../themes/custom_app_theme.dart';
import '../../translate/language_store.dart';
import '../../utils/local_shared_Storage.dart';

class HomeBulletinIndexPage extends ConsumerWidget {
  const HomeBulletinIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bulletinList =
        ref.watch(bulletinIndexModelProvider).bulletinIndex.toList();
    // bool _isDataLoading = true;

    // final languageCode = ref.watch(languageProvider).data?.value;

    IconData? getIconData(String iconName) {
      try {
        final iconData = MdiIcons.fromString(iconName);

        return iconData;
      } catch (e) {
        return null;
      }
    }

    Future<void> fetchAndPopulateListData({
      // required String language_code,
      required int indexId,
    }) async {
      String languageCode = await LocalSharedStorage().getLanguageCode();
      debugPrint('languageCode : $languageCode');
      try {
        // Check if data for the specified language and index is already available
        if (ref.read(bulletinListSuccessProvider)[indexId] ?? false) {
          return; // Data is already available, no need to fetch again
        }

        // Fetch data from the server
        final newBulletinList =
            await ref.read(bulletinListServiceProvider).getBulletinListData(
                  bulletinLanguage: languageCode,
                  bulletinIndexId: indexId,
                );

        if (newBulletinList != null) {
          // addBulletin method in  notifier takes a BulletinListModelList
          ref
              .read(bulletinListModelProvider.notifier)
              .addBulletinListModels(newBulletinList);

          // Mark the success once data is loaded
          ref
              .read(bulletinListSuccessProvider.notifier)
              .setEventSuccess(indexId, true);
        }
      } finally {
        // Set _isDataLoading to false once data loading is complete
        // _isDataLoading =
        //     ref.read(bulletinListModelProvider).bulletinList.isEmpty;
      }
    }

    void handleButtonPress(
      BuildContext context,
      // language_code,
      int indexId,
      String newRoute,
    ) async {
      // Show CircularProgressIndicator while fetching data
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await fetchAndPopulateListData(
          // language_code: language_code,
          indexId: indexId,
        );

        ref.read(selectedBulletinIndexIdProvider.notifier).state = indexId;
        GoRouter.of(context).goNamed(newRoute);
      } finally {
        // Close the CircularProgressIndicator dialog
        Navigator.of(context).pop();
      }
    }

    return Theme(
      data: CustomAppTheme.themeData
          .copyWith(cardTheme: CustomAppTheme.themeData.cardTheme),
      child: Scaffold(
        body: ListView.builder(
          itemCount: bulletinList.length,
          itemBuilder: (context, index) {
            BulletinIndexModel category = bulletinList[index];
            IconData iconData =
                getIconData(category.bulletinIndexIconKey) ?? Icons.article;
            // Default to error icon if key not found

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  iconData,
                  size: 28,
                ),
                title: Text(
                  category.bulletinIndexName,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Discover Stories: ${category.totalRecord}'),
                onTap: () {
                  debugPrint('Discover Stories: ${category.totalRecord}');
                  // Handle onTap event for the card
                },
                trailing: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: category.totalRecord > 0
                            ? () => handleButtonPress(
                                context,
                                // languageCode,
                                category.bulletinIndexId,
                                AppRouteConstants.bulletinCarouselPageRouteName)
                            : null,
                        child: const Icon(Icons.view_carousel),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: category.totalRecord > 0
                            ? () => handleButtonPress(
                                  context,
                                  // languageCode,
                                  category.bulletinIndexId,
                                  AppRouteConstants.bulletinListPageRouteName,
                                )
                            : null,
                        child: const Icon(Icons.view_list),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
