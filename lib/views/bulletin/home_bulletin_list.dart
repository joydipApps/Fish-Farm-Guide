import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/bulletin_list_model.dart';
import '../../provider/bulletin/bulletin_index_provider.dart';
import '../../provider/bulletin/bulletin_list_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../routes/app_route_constants.dart';
import '../../themes/custom_app_theme.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_methods.dart';

class HomeBulletinListPage extends ConsumerWidget {
  const HomeBulletinListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int bulletinIndexId = ref.read(selectedBulletinIndexIdProvider);

    // final bulletinList =
    //     ref.watch(bulletinListModelProvider).bulletinList.toList();

    final List<BulletinListModel> bulletinList = ref
        .watch(bulletinListModelProvider)
        .bulletinList
        .where((bulletin) => bulletin.bulletinIndexId == bulletinIndexId)
        .toList();

    IconData? getIconData(String iconName) {
      try {
        final iconData = MdiIcons.fromString(iconName);

        return iconData;
      } catch (e) {
        return null;
      }
    }

    return Theme(
      data: CustomAppTheme.themeData
          .copyWith(cardTheme: CustomAppTheme.themeData.cardTheme),
      child: Scaffold(
        appBar: commonAppBar(context, 'Bulletin List',
            isIconBack: true, showBottomTabBar: false),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: bulletinList.length,
                itemBuilder: (context, index) {
                  BulletinListModel category = bulletinList[index];
                  IconData iconData =
                      getIconData(category.bulletinHeader) ?? Icons.article;
                  // Default to error icon if key not found

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(
                        iconData,
                        size: 28,
                      ),
                      title: Text(
                        category.bulletinHeader,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(formatBulletinDate(category.bulletinDate)),
                      onTap: () {
                        ref.read(selectedBulletinIdProvider.notifier).state =
                            category.bulletinId;
                        GoRouter.of(context).goNamed(
                          AppRouteConstants.bulletinDetailsPageRouteName,
                        );
                        // Handle onTap event for the card
                      },
                      trailing: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Icon(Icons.touch_app),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
