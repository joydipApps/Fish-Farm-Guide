// custom_app_bar.dart - checked
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/welcome_button_provider.dart';
import '/widgets/social_media.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_route_constants.dart';
import '../translate/language_selection.dart';
import '../utils/constants.dart';

AppBar commonAppBar(context, text,
    {isIconBack = true, showBottomTabBar = false}) {
  return AppBar(
    backgroundColor: Colors.lightBlue.shade900, // added theme not working
    toolbarHeight: kToolbarHeight,
    toolbarTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16,
    ),
    elevation: 10.0,
    leading: isIconBack
        ? Consumer(
            builder: (context, ref, child) {
              final menuChoice = ref.watch(menuStateProvider);
              GoRouter goRouter = GoRouter.of(context);

              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                iconSize: 24,
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    if (menuChoice == 1) {
                      goRouter.pushNamed(AppRouteConstants.homeRouteName);
                    } else if (menuChoice == 2) {
                      goRouter.pushNamed(
                          AppRouteConstants.homeConsultPageRouteName);
                    }
                  }
                },
              );
            },
          )
        : Builder(
            builder: (BuildContext builderContext) {
              return IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                iconSize: 24, // Replace with your menu icon
                onPressed: () {
                  // Handle the menu icon press here
                  Scaffold.of(builderContext).openDrawer(); // Open the drawer
                },
              );
            },
          ),
    title: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        '$text',
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white),
      ),
    ),

    bottom: showBottomTabBar
        ? const PreferredSize(
            preferredSize: Size.fromHeight(35.0),
            child: Column(
              children: [
                Divider(height: 1.0, color: Colors.grey), // Thin line
                TabBar(
                  indicatorColor: Colors.red,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_books,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Index',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Bulletin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Book Mark',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : null,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.language),
        color: Colors.white,
        iconSize: 22,
        onPressed: () {
          showLanguageSelectionDialog(context);
        },
      ),
      const SizedBox(width: 0),
      buildShareIconButton(
        context,
        kColor: Colors.white,
        kShareBody: kShareTopic,
        kShareSubject: kShareSubject,
      ),
      const SizedBox(width: 0),
      IconButton(
        icon: const Icon(Icons.exit_to_app),
        iconSize: 22,
        color: Colors.white,
        onPressed: () {
          _showLogoutDialog(context); // Call the logout function
        },
      ),
      const SizedBox(width: 0),
    ],
  );
}

Future<void> _showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow.shade100,
        shadowColor: Colors.red,
        title: const Text(
          'Stop Reading :',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to exit?'),
        actions: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                    children: [
                      Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.green.shade700, // Set the icon color
                      ),
                      const SizedBox(
                          width: 5), // Adjust the spacing between icon and text
                      Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade700, // Set the text color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    while (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }

                    final goRouter = GoRouter.of(context);
                    goRouter.pushNamed(AppRouteConstants.welcomeRouteName);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    shadowColor: Colors.yellowAccent,
                    backgroundColor:
                        Colors.yellow.shade100, // Set the button color
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.stop,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
