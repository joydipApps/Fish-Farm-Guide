// app_route_config - checked
import 'package:fishfarmguide_prod/views/consult/expert/sme_view_page.dart';
import 'package:fishfarmguide_prod/views/consult/register/register_user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../views/bulletin/home_bulletin_list.dart';
import '../../views/welcome/splash_screen.dart';

import '../views/bulletin/home_bulletin_carousel.dart';
import '../views/bulletin/home_bulletin_details.dart';
import '../views/bulletin/home_bulletin_index.dart';
import '../views/common/coming_soon_page.dart';
import '../views/common/objective_info_page.dart';
import '../views/common/author_page.dart';
import '../views/common/developer_info_page.dart';
import '../views/common/package_info_page.dart';
import '../views/common/terms_and_conditions_page.dart';
import '../../views/book/home/home_book_page.dart';
import '../views/consult/home/home_consult_page.dart';
import '../views/consult/question/question_list_page.dart';
import '../views/welcome/welcome_page.dart';
import 'app_route_constants.dart';
import '../views/common/about_us_page.dart';
import '../views/common/contact_us_page.dart';
import '../views/common/error_page.dart';

// GoRouter configuration
class MyAppRouteConfig {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      // root - splash  screen
      GoRoute(
          name: AppRouteConstants.splashScreenRouteName,
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SplashScreen())),

      //  welcome page
      GoRoute(
          name: AppRouteConstants.welcomeRouteName,
          path: '/welcome',
          pageBuilder: (context, state) =>
              const MaterialPage(child: WelcomePage())),

      // Sign up page
      GoRoute(
          name: AppRouteConstants.signUpRouteName,
          path: '/signUp',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ComingSoonPage())),

      // Sign - In Page
      GoRoute(
          name: AppRouteConstants.signInRouteName,
          path: '/signIn',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ComingSoonPage())),

      GoRoute(
          name: AppRouteConstants.aboutUsPageRouteName,
          path: '/about',
          pageBuilder: (context, state) =>
              const MaterialPage(child: AboutUsPage())),
      GoRoute(
          name: AppRouteConstants.objectiveInfoPageRouteName,
          path: '/objective',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ObjectiveInfoPage())),

      GoRoute(
          name: AppRouteConstants.contactUsPageRouteName,
          path: '/contact',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ContactUsPage())),
      GoRoute(
          name: AppRouteConstants.termsAndConditionsPageRouteName,
          path: '/terms',
          pageBuilder: (context, state) =>
              const MaterialPage(child: TermsAndConditionsPage())),

      GoRoute(
          name: AppRouteConstants.packageInfoPageRouteName,
          path: '/package-info',
          pageBuilder: (context, state) =>
              const MaterialPage(child: PackageInfoPage())),

      GoRoute(
          name: AppRouteConstants.developerInfoPageRouteName,
          path: '/coming-soon',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DeveloperInfoPage())),

      GoRoute(
          name: AppRouteConstants.profilePageRouteName,
          path: '/profile',
          pageBuilder: (context, state) =>
              const MaterialPage(child: AuthorPage())),

      GoRoute(
        name: AppRouteConstants.homeRouteName,
        path: '/home',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeBookPage(),
        ),
      ),

      // Bulletin Pages

      GoRoute(
        name: AppRouteConstants.bulletinIndexPageRouteName,
        path: '/bulletin-index',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeBulletinIndexPage(),
        ),
      ),

      GoRoute(
        name: AppRouteConstants.bulletinListPageRouteName,
        path: '/bulletin-list',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeBulletinListPage(),
        ),
      ),

      GoRoute(
        name: AppRouteConstants.bulletinCarouselPageRouteName,
        path: '/bulletin-carousel',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeBulletinCarouselPage(),
        ),
      ),
      GoRoute(
        name: AppRouteConstants.bulletinDetailsPageRouteName,
        path: '/bulletin-details',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeBulletinDetailsPage(),
        ),
      ),

      // App Consult section

      GoRoute(
        name: AppRouteConstants.homeConsultPageRouteName,
        path: '/home-consult-page',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomeConsultPage(),
        ),
      ),

      // registerUserPageRouteName

      GoRoute(
        name: AppRouteConstants.registerUserPageRouteName,
        path: '/register-user',
        pageBuilder: (context, state) => const MaterialPage(
          child: RegisterUser(),
        ),
      ),

      // question list page
      GoRoute(
        name: AppRouteConstants.questionListPageRouteName,
        path: '/question-list-page',
        pageBuilder: (context, state) => const MaterialPage(
          child: QuestionListPage(),
        ),
      ),

      // smeViewPageRouteName
      GoRoute(
        name: AppRouteConstants.smeViewPageRouteName,
        path: '/sme-view-page',
        pageBuilder: (context, state) => const MaterialPage(
          child: SMEViewPage(),
        ),
      ),

      GoRoute(
          name: AppRouteConstants.errorPageRouteName,
          path: '/error',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ErrorPage())),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );
}
