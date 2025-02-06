// home_drawer.dart - checked
import 'package:fishfarmguide_prod/services/consult/expert/fetch_sme_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/app_route_constants.dart';
import '../../../translate/language_selection.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: 64,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.lightBlue.shade800),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          // Close the drawer when the close button is pressed
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Setup Language',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    showLanguageSelectionDialog(context);
                  },
                ),
                // opened on 12feb24
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: const Text(
                    'Book Author',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.profilePageRouteName);
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ListTile(
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: const Text(
                        'Subject Matter Experts',
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        fetchSMEListFunction(context, ref).then((_) {
                          GoRouter.of(context)
                              .goNamed(AppRouteConstants.smeViewPageRouteName);
                        });
                      },
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.star, color: Colors.black),
                  title: const Text(
                    'Objective',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                        AppRouteConstants.objectiveInfoPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.black),
                  title: const Text(
                    'About Us',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.aboutUsPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_mail, color: Colors.black),
                  title: const Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.contactUsPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.library_books, color: Colors.black),
                  title: const Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                        AppRouteConstants.termsAndConditionsPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.black),
                  title: const Text(
                    'Package Information',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.packageInfoPageRouteName);
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.smartphone, color: Colors.black),
                //   title: Text(
                //     'Developed By',
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   onTap: () {
                //     GoRouter.of(context)
                //         .pushNamed(AppRouteConstants.bookListPageRouteName);
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
