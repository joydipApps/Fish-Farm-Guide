import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/consult/question/question_list.dart';
import '../../../services/consult/question/question_list_service.dart';

final questionListModelProvider =
    StateNotifierProvider<QuestionListModelNotifier, List<QuestionListModel>>(
        (ref) {
  return QuestionListModelNotifier();
});

final questionListServiceProvider = Provider<QuestionListService>((ref) {
  return QuestionListService();
});

// return success catId wise
// unique notifier for each catId
// Return success catId-wise
final questionListSuccessProvider =
    StateNotifierProvider.family<QuestionListSuccessNotifier, bool, String>(
  (ref, catId) => QuestionListSuccessNotifier(catId),
);

class QuestionListSuccessNotifier extends StateNotifier<bool> {
  final String catId;

  QuestionListSuccessNotifier(this.catId)
      : super(false); // Initialize with false

  void setQuestionCategorySuccess(bool value) {
    state = value;
  }
}
