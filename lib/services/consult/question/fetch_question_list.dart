import 'package:fishfarmguide_prod/models/consult/question/question_category_list.dart';
import 'package:fishfarmguide_prod/provider/consult/question/question_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/consult/question/question_list.dart';
import '../../../provider/consult/question/question_list_provider.dart';
import '../../../provider/welcome_button_provider.dart';
import '../../../utils/show_progress_dialog.dart';

Future<void> fetchQuestionListFunction(
  BuildContext context,
  WidgetRef ref,
  String catId,
) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final bool success = ref.watch(questionListSuccessProvider(catId));
    debugPrint('questionListFunction value: $success');

    if (!success) {
      debugPrint('questionListFunction:Fetching data');

      final List<QuestionListModel>? questionList = await ref
          .read(questionListServiceProvider)
          .fetchQuestionList(context, catId);

      if (questionList != null && questionList.isNotEmpty) {
        debugPrint(
            'questionListFunction:category List fetched successfully: ${questionList.length} records');

        ref
            .read(questionListModelProvider.notifier)
            .setAllQuestions(questionList);
        debugPrint(
            'questionListFunction: list data added to Provider: $questionList');

        ref
            .read(questionListSuccessProvider(catId).notifier)
            .setQuestionCategorySuccess(true);
      } else {
        debugPrint('questionListFunction:data is null or empty');
      }
    } else {
      debugPrint('questionListFunction: list already fetched successfully');
    }
  } catch (e) {
    // Handle error
    debugPrint('questionCategoryListFunction:Error fetching  list: $e');
  } finally {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
