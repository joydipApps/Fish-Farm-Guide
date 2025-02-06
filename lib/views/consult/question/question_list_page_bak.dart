// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../provider/consult/question/question_category_provider.dart';
// import '../../../provider/consult/question/question_list_provider.dart';
// import '../../../widgets/common_app_bar.dart';
//
// class QuestionListPage extends ConsumerWidget {
//   const QuestionListPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Fetch the list of question categories from the provider
//     final questionList = ref.watch(questionListModelProvider);
//
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'Question List',
//         isIconBack: true,
//         showBottomTabBar: false,
//       ),
//       body: ListView.builder(
//         itemCount: questionList.length,
//         itemBuilder: (context, index) {
//           final question = questionList[index];
//
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListTile(
//                   leading: Image.memory(
//                     base64Decode(question.quesImage),
//                     width: 35, // Set thumbnail size
//                     height: 35,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Icon(Icons.image_not_supported);
//                     },
//                   ),
//                   title: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(question.quesId,
//                               style: const TextStyle(fontSize: 16.0)),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               question.quesName,
//                               style: const TextStyle(fontSize: 18.0),
//                               softWrap: true,
//                               maxLines: 3,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.select_all),
//                             onPressed: () {
//                               // Handle add action
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
