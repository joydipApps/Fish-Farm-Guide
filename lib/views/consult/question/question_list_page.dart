import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/consult/question/question_category_provider.dart';
import '../../../provider/consult/question/question_list_provider.dart';
import '../../../widgets/common_app_bar.dart';

class QuestionListPage extends ConsumerWidget {
  const QuestionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the list of question categories from the provider
    final questionList = ref.watch(questionListModelProvider);

    return Scaffold(
      appBar: commonAppBar(
        context,
        'Ask Question',
        isIconBack: true,
        showBottomTabBar: false,
      ),
      body: ListView.builder(
        itemCount: questionList.length,
        itemBuilder: (context, index) {
          final question = questionList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Show image in a dialog with increased size
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Image.memory(
                              base64Decode(question.quesImage),
                              width: 240,
                              height: 240,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image_not_supported,
                                    size: 100);
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Image.memory(
                          base64Decode(question.quesImage),
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported,
                                size: 35);
                          },
                        ),
                      ),
                    ),

                    // Top right quadrant: Question name
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Text(
                          question.quesName,
                          style: const TextStyle(fontSize: 18.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // const Spacer(),
                    Text(
                      question.quesId,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.right,
                    ),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.touch_app_sharp,
                      ),
                      label: const Text("প্রশ্ন করুন"),
                      onPressed: () {
                        // Handle select action here
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueAccent.shade700,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0), // Set text/icon color
                      ),
                    ),

                    // const Spacer(),
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.chat_bubble_outline_rounded,
                    //   ),
                    //   onPressed: () {
                    //     // Handle select action here
                    //   },
                    // ),
                    // const Spacer(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
