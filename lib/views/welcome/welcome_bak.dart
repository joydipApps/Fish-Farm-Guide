// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hive/hive.dart';
// import '../../provider/all_providers.dart';
// import '../../routes/app_route_constants.dart';
// import '../../services/data_store/box_service.dart';
//
// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});
//
//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }
//
// class _WelcomePageState extends State<WelcomePage> {
//   final String baseImageName = 'assets/images/fish_book';
//   final int numberOfImages = 48;
//   final PageController _pageController = PageController();
//   int currentPage = 0;
//   bool isPageScrolling = false;
//
//   String getRandomImage() {
//     final random = Random();
//     final randomIndex = random.nextInt(numberOfImages) + 1; // Add 1 to avoid 0
//     return '$baseImageName$randomIndex.jpg'; // Assumes your image files have .jpg extension
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       if (!_pageController.page!.isFinite) {
//         setState(() {
//           isPageScrolling = false;
//         });
//       } else {
//         if (!_pageController.page!.isNegative &&
//             !_pageController.page!.isInfinite) {
//           if (!isPageScrolling) {
//             setState(() {
//               currentPage = _pageController.page!.round();
//               isPageScrolling = true;
//             });
//           }
//         }
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   // keep for next version.
//   // @override
//   // void didChangeDependencies() {
//   //   precacheImage(
//   //     AssetImage('assets/wallpaper/fish_back.jpg'),
//   //     context,
//   //   );
//   //
//   //   // Check if the image is already cached before precaching
//   //   final provider = DefaultCacheManager();
//   //   final key = provider.getSingleFileUrl('assets/wallpaper/fish_back.jpg');
//   //
//   //   if (key == null) {
//   //     // The image is not in the cache, so precache it
//   //     precacheImage(
//   //       AssetImage('assets/wallpaper/fish_back.jpg'),
//   //       context,
//   //     );
//   //   }
//   //
//   //   super.didChangeDependencies();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // final goRouter = GoRouter.of(context);
//     final double screenWidth = MediaQuery.of(context).size.width;
//     const double aspectRatio = 1.0; // 16:9 aspect ratio
//     final double imageHeight = screenWidth / aspectRatio;
//
//     return Stack(
//       children: [
//         // Background Image
//         Positioned.fill(
//           child: Opacity(
//             opacity: 0.7,
//             child: Image.asset(
//               'assets/wallpaper/fish_back.jpg',
//               fit: BoxFit.cover,
//               width: screenWidth,
//               height: imageHeight,
//               colorBlendMode: BlendMode.hardLight,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   onPageChanged: (index) {
//                     setState(() {
//                       currentPage = index;
//                     });
//                   },
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 3, // Number of pages
//                   itemBuilder: (context, index) {
//                     String title = '';
//                     String description = '';
//                     switch (index) {
//                       case 0:
//                         title =
//                             'Fish Farm Guide\nFlexible Learning for\n Successful Aquaculture';
//                         description =
//                             'Anywhere, anytime. The time is at your discretion so study whenever you want.';
//                         break;
//                       case 1:
//                         title =
//                             'Fish Farm Guide\nNurturing Expertise\n Through Lifelong Learning';
//                         description =
//                             'Learning is the net we cast into the ocean of knowledge, and with each new lesson, we catch a brighter future in the world of fish farming.';
//                         break;
//                       case 2:
//                         title =
//                             'Fish Farm Guide\nBuilding a Supportive \n Aquaculture Community';
//                         description =
//                             'Always keep in touch with your tutor & friend. let’s get connected!';
//                         break;
//                     }
//                     return WelcomeScreen(
//                       title: title,
//                       description: description,
//                       imageAsset: getRandomImage(),
//                     );
//                   },
//                 ),
//               ),
//               // Right Arrow Button
//             ],
//           ),
//         ),
//
//         Positioned(
//           bottom: 20.0,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(3, (index) {
//               return Container(
//                 width: 10.0,
//                 height: 10.0,
//                 margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: currentPage == index ? Colors.yellow : Colors.grey,
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class WelcomeScreen extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imageAsset;
//
//   const WelcomeScreen({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.imageAsset,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           // decoration: ,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 imageAsset,
//                 height: 300.0,
//                 width: 300.0,
//               ),
//
//               const SizedBox(height: 10.0),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(
//                       color: Colors.black, // Shadow color
//                       blurRadius: 2, // Blur radius
//                       offset: Offset(1, 1), // Shadow offset
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10.0),
//               Text(
//                 description,
//                 style: const TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(
//                       color: Colors.black, // Shadow color
//                       blurRadius: 2, // Blur radius
//                       offset: Offset(1, 1), // Shadow offset
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//               const SizedBox(height: 10.0),
//               Consumer(builder: (context, ref, child) {
//                 final buttonState = ref.watch(welcomeButtonStateProvider);
//                 return ElevatedButton(
//                   onPressed: buttonState
//                       ? () {
//                           // Disable the button to prevent duplicate clicks
//                           ref
//                               .read(welcomeButtonStateProvider.notifier)
//                               .disableButton();
//                           GoRouter.of(context)
//                               .goNamed(AppRouteConstants.homeRouteName);
//                         }
//                       : null,
//                   style: ButtonStyle(
//                     elevation: WidgetStateProperty.all(10),
//                     shadowColor: WidgetStateProperty.all(Colors.white54),
//                     backgroundColor: WidgetStateProperty.resolveWith((states) {
//                       if (states.contains(WidgetState.pressed)) {
//                         // Color when the button is pressed
//                         return Colors.lightBlue.shade700;
//                       }
//                       // Default color
//                       return Colors.lightBlue.shade900;
//                     }),
//                   ),
//                   child: const Text(
//                     "Open Guide - Start Reading 📚",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 );
//               }),
//               //TextButton(onPressed: onPressed, child: child)
//               const SizedBox(height: 5),
//               TextButton(
//                 onPressed: () async {
//                   await BoxService().closeBookmarkBox();
//                   await Hive.close();
//                   debugPrint("Hive Database closed");
//                   SystemNavigator.pop();
//                 },
//                 child: Text(
//                   'Close Guide - Go Fishing ',
//                   style: TextStyle(
//                     color: Colors.grey.shade200,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
