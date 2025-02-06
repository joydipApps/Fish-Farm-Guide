import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/consult/question/question_category_list.dart';
import '../../../services/consult/question/question_category_service.dart';

final questionCategoryListModelProvider = StateNotifierProvider<
    QuestionCategoryListModelNotifier, List<QuestionCategoryListModel>>((ref) {
  debugPrint('1. Creating questionCategoryListModelProvider'); // Debug point 1
  return QuestionCategoryListModelNotifier();
});

final questionCategoryListServiceProvider =
    Provider<QuestionCategoryListService>((ref) {
  return QuestionCategoryListService();
});

final questionCategoryListSuccessProvider =
    StateNotifierProvider<QuestionCategoryListSuccessNotifier, bool>((ref) {
  return QuestionCategoryListSuccessNotifier(); // You'll need to create this notifier class
});

class QuestionCategoryListSuccessNotifier extends StateNotifier<bool> {
  QuestionCategoryListSuccessNotifier() : super(false); // Initialize with false

  void setQuestionCategoryListSuccess(bool value) {
    state = value;
  }
}
