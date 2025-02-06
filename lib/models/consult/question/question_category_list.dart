import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionCategoryListModel {
  final String catId;
  final String catImage;
  final String catName;

  QuestionCategoryListModel({
    required this.catId,
    required this.catImage,
    required this.catName,
  });

  factory QuestionCategoryListModel.fromJson(Map<String, dynamic> json) {
    String catId = (json['dep_list_id'] as String?)?.trim() ?? '';
    String catImage = (json['base64_image'] as String?)?.trim() ?? '';
    String catName = (json['dep_list_name'] as String?)?.trim() ?? '';

    return QuestionCategoryListModel(
      catId: catId,
      catImage: catImage,
      catName: catName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dep_list_id": catId,
      "base64_image": catImage,
      "dep_list_name": catName,
    };
  }
}

class QuestionCategoryListModelNotifier
    extends StateNotifier<List<QuestionCategoryListModel>> {
  QuestionCategoryListModelNotifier()
      : super([]); // Initialize with an empty list

  void setCategory(QuestionCategoryListModel newCategory) {
    state = [newCategory]; // Replace the entire list with a single category
  }

  void addCategory(QuestionCategoryListModel newCategory) {
    state = [
      ...state,
      newCategory
    ]; // Add a single category to the existing list
  }

  void setAllCategories(List<QuestionCategoryListModel> newCategoryList) {
    state =
        newCategoryList; // Replace the entire list with a new list of categories
  }
}
