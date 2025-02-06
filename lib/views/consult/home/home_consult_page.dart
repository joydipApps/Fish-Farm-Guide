import 'package:fishfarmguide_prod/views/consult/register/register_user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../routes/app_route_constants.dart';
import '../../../widgets/common_app_bar.dart';
import '../../book/home/home_drawer.dart';
import '../question/question_category_list_page.dart';
import 'home_consult_bottom_page.dart';

class HomeConsultPage extends ConsumerStatefulWidget {
  const HomeConsultPage({super.key});

  @override
  HomeConsultPageState createState() => HomeConsultPageState();
}

class HomeConsultPageState extends ConsumerState<HomeConsultPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final goRouter = GoRouter.of(context);

    switch (_selectedIndex) {
      case 0:
        goRouter.pushNamed(AppRouteConstants.welcomeRouteName);
        break;
      case 1:
        // Define navigation for the second tab here
        //goRouter.pushNamed(AppRouteConstants.answersRouteName);
        break;
      case 2:
        // Define navigation for the third tab here
        //goRouter.pushNamed(AppRouteConstants.expertsRouteName);
        break;
      case 3:
        goRouter.pushNamed(AppRouteConstants.registerUserPageRouteName);
        break;
      case 4:
        break;
      case 5:
        // goRouter.pushNamed(AppRouteConstants.registerUserPageRouteName);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, 'Question Groups', isIconBack: false),
      drawer: const HomeDrawer(),
      body:
          GetSelectedPage(selectedIndex: _selectedIndex), // Pass selectedIndex
      bottomNavigationBar: HomeConsultBottomPage(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class GetSelectedPage extends StatelessWidget {
  final int selectedIndex;

  const GetSelectedPage({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return const QuestionCategoryListPage(); // Replace with actual widget for Home
      case 1:
        return const Placeholder(); // Replace with actual widget for Answers
      case 2:
        return const Placeholder();
      case 3:
      case 5:
        return const Placeholder();
      default:
        return const QuestionCategoryListPage(); // Default case
      // Default case
    }
  }
}
