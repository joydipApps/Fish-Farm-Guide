// // home_book_page.dart - checked
// import 'package:flutter/material.dart';
// import '../../../provider/bulletin/bulletin_index_provider.dart';
// import '../../../provider/books/books_index_provider.dart';
// import '../../../widgets/common_app_bar.dart';
// import '../../bulletin/home_bulletin_index.dart';
// import 'home_book_mark.dart';
// import 'home_book_index.dart';
// import 'home_drawer.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class HomeBookPage extends ConsumerStatefulWidget {
//   const HomeBookPage({super.key});
//
//   @override
//   HomeBookPageState createState() => HomeBookPageState();
// }
//
// class HomeBookPageState extends ConsumerState<HomeBookPage> {
//   bool _isDataLoading = true; // Track whether data is loading
//
//   @override
//   void initState() {
//     super.initState();
//      _fetchAndPopulateData();
//   }
//
//   void _fetchAndPopulateData() async {
//     try {
//       // Populate Book Index Data
//       // Check if data has already been successfully loaded
//       if (!ref.read(bookIndexSuccessProvider)) {
//         // If not, fetch data from the server
//         final newBookIndex =
//         await ref.read(bookIndexServiceProvider).getBookIndexData();
//
//         if (newBookIndex != null) {
//           // Assuming addBook method in your notifier takes a BookIndexModelList
//           ref.read(bookIndexModelProvider.notifier).addBooks(newBookIndex);
//
//           // Mark the success once data is loaded
//           ref.read(bookIndexSuccessProvider.notifier).setEventSuccess(true);
//         }
//       }
//
//       //  *** Populate Bulletin Index ***
//       // Check if data has already been successfully loaded
//
//       if (!ref.read(bulletinIndexSuccessProvider)) {
//         // If not, fetch data from the server
//         final newBulletinIndex =
//         await ref.read(bulletinIndexServiceProvider).getBulletinIndexData();
//
//         if (newBulletinIndex != null) {
//           // Assuming addBulletin method in your notifier takes a BulletinIndexModelList
//           ref
//               .read(bulletinIndexModelProvider.notifier)
//               .addBulletinIndexes(newBulletinIndex);
//
//           // Mark the success once data is loaded
//           ref.read(bulletinIndexSuccessProvider.notifier).setEventSuccess(true);
//         }
//       }
//     } finally {
//       // Set _isDataLoading to false once data loading is complete
//       if (mounted) {
//         setState(() {
//           _isDataLoading = (ref.read(bookIndexModelProvider).books.isEmpty ||
//               ref.read(bulletinIndexModelProvider).bulletinIndex.isEmpty);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: commonAppBar(context, 'Library',
//             isIconBack: false, showBottomTabBar: true),
//         drawer: const HomeDrawer(),
//         body: _isDataLoading
//             ? const Center(
//           child: CircularProgressIndicator(),
//         )
//             : const TabBarView(
//           children: [
//             // First tab content: Index
//             HomeBookIndexPage(),
//             // Second tab content: Bulletins
//             HomeBulletinIndexPage(),
//             // Third tab content: Book Mark
//             HomeBookMarkPage(),
//           ],
//         ),
//       ),
//     );
//   }
// }
