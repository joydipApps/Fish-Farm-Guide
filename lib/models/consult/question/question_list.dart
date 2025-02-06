import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionListModel {
  final String quesId;
  final String catId;
  final String quesImage;
  final String quesName;

  QuestionListModel({
    required this.quesId,
    required this.catId,
    required this.quesImage,
    required this.quesName,
  });

  factory QuestionListModel.fromJson(Map<String, dynamic> json) {
    String quesId = (json['q_id'] as String?)?.trim() ?? '';
    String catId = (json['dep_list_id'] as String?)?.trim() ?? '';
    String quesImage = (json['base64_image'] as String?)?.trim() ?? '';
    String quesName = (json['question'] as String?)?.trim() ?? '';

    return QuestionListModel(
      quesId: quesId,
      catId: catId,
      quesImage: quesImage,
      quesName: quesName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "q_id": quesId,
      "dep_list_id": catId,
      "base64_image": quesImage,
      "question": quesName,
    };
  }
}

class QuestionListModelNotifier extends StateNotifier<List<QuestionListModel>> {
  QuestionListModelNotifier() : super([]); // Initialize with an empty list

  void updateQuestion(QuestionListModel updatedQuestion) {
    state = [
      for (var question in state)
        if (question.quesId == updatedQuestion.quesId)
          updatedQuestion
        else
          question
    ];
  }

  void setQuestion(QuestionListModel newQuestion) {
    state = [newQuestion]; // Replace the entire list with a single question
  }

  void addQuestion(QuestionListModel newQuestion) {
    state = [
      ...state,
      newQuestion
    ]; // Add a single question to the existing list
  }

  void setAllQuestions(List<QuestionListModel> newQuestionList) {
    state =
        newQuestionList; // Replace the entire list with a new list of questions
  }
}
