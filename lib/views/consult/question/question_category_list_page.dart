import 'dart:convert';
import 'package:fishfarmguide_prod/services/consult/question/fetch_question_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../provider/consult/question/question_category_provider.dart';
import '../../../routes/app_route_constants.dart';

class QuestionCategoryListPage extends ConsumerWidget {
  const QuestionCategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the list of question categories from the provider
    final questionCategories = ref.watch(questionCategoryListModelProvider);
    GoRouter goRouter = GoRouter.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Question Categories'),
      // ),
      body: ListView.builder(
        itemCount: questionCategories.length,
        itemBuilder: (context, index) {
          final category = questionCategories[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  // Show image in a dialog with increased size
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Image.memory(
                        base64Decode(category.catImage),
                        width: 240, // Four times the original width (4 * 60)
                        height: 240, // Four times the original height (4 * 60)
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported,
                              size: 100);
                        },
                      ),
                    ),
                  );
                },
                child: Image.memory(
                  base64Decode(category.catImage),
                  width: 35, // Set thumbnail size
                  height: 35,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
              title: Row(
                children: [
                  Text(category.catId, style: const TextStyle(fontSize: 16.0)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      category.catName,
                      style: const TextStyle(fontSize: 18.0),
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              onTap: () {
                fetchQuestionListFunction(context, ref, category.catId)
                    .then((_) {
                  GoRouter.of(context)
                      .goNamed(AppRouteConstants.questionListPageRouteName);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
