import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_route_constants.dart';

class HomeConsultBottomPage extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HomeConsultBottomPage({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    GoRouter goRouter = GoRouter.of(context);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.event,
            color: Colors.black,
          ),
          label: 'Answers',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.group,
            color: Colors.black,
          ),
          label: 'Experts',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.red,
          ),
          label: 'Register',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 24.0,
            child: Consumer(
              builder: (context, ref, child) => PopupMenuButton<int>(
                padding: const EdgeInsets.only(bottom: 5),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Add Seed Sale'),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Text('Add Enquiry'),
                  ),
                  // Add more PopupMenuItems as needed
                  const PopupMenuItem(
                    value: 3,
                    child: Text('Picture/Video'),
                  ),
                  const PopupMenuItem(
                    value: 4,
                    child: Text('Location'),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      goRouter.pushNamed(AppRouteConstants.welcomeRouteName);
                      break;
                    case 2:
                      // goRouter
                      //     .pushNamed(AppRouteConstants.addEnquiryPageRouteName);
                      break;
                    case 3:
                      // goRouter
                      //     .pushNamed(AppRouteConstants.editImagePageRouteName);
                      break;
                    case 4:
                      break;
                    case 5:
                      goRouter.pushNamed(
                          AppRouteConstants.registerUserPageRouteName);

                      break;
                    default:
                      // Handle default case
                      break;
                  }
                },
              ),
            ),
          ),
          label: 'More',
        ),
      ],
    );
  }
}
