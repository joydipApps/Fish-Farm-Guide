import 'package:fishfarmguide_prod/models/consult/question/question_category_list.dart';
import 'package:fishfarmguide_prod/provider/consult/question/question_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/welcome_button_provider.dart';
import '../../../utils/show_progress_dialog.dart';

Future<void> fetchQuestionCategoryListFunction(
  BuildContext context,
  WidgetRef ref,
) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    // Fetch location List data
    ref.read(loadingStateProvider.notifier).state = true; // Start loading
    final bool success = ref.watch(questionCategoryListSuccessProvider);
    debugPrint('questionCategoryListFunction value: $success');

    if (!success) {
      debugPrint('questionCategoryListFunction:Fetching data');

      final List<QuestionCategoryListModel>? categoryList = await ref
          .read(questionCategoryListServiceProvider)
          .fetchQuestionCategoryList(
            context,
          );

      if (categoryList != null && categoryList.isNotEmpty) {
        debugPrint(
            'questionCategoryListFunction:category List fetched successfully: ${categoryList.length} records');

        ref
            .read(questionCategoryListModelProvider.notifier)
            .setAllCategories(categoryList);
        debugPrint(
            'questionCategoryListFunction: list data added to Provider: $categoryList');

        ref
            .read(questionCategoryListSuccessProvider.notifier)
            .setQuestionCategoryListSuccess(true);
        debugPrint('questionCategoryListFunction: SuccessProvider set to true');
      } else {
        debugPrint('questionCategoryListFunction:data is null or empty');
      }
    } else {
      debugPrint(
          'questionCategoryListFunction: list already fetched successfully');
    }
  } catch (e) {
    // Handle error
    debugPrint('questionCategoryListFunction:Error fetching  list: $e');
  } finally {
    ref.read(loadingStateProvider.notifier).state = false;
    // Stop loading
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
