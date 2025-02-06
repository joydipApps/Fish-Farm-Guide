import 'dart:convert';
import 'package:fishfarmguide_prod/provider/consult/experts/sme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SMEViewPage extends ConsumerWidget {
  const SMEViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the list of question categories from the provider
    final smeList = ref.watch(smeModelProvider);
    GoRouter goRouter = GoRouter.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Question Categories'),
      // ),
      body: ListView.builder(
        itemCount: smeList.length,
        itemBuilder: (context, index) {
          final experts = smeList[index];

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
                        base64Decode(experts.expertPicture),
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
                  base64Decode(experts.expertPicture),
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
                  // Text(experts.expertId,
                  //     style: const TextStyle(fontSize: 16.0)),
                  // const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      experts.expertName,
                      style: const TextStyle(fontSize: 18.0),
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              // onTap: () {
              //   fetchQuestionListFunction(context, ref, category.catId)
              //       .then((_) {
              //     GoRouter.of(context)
              //         .goNamed(AppRouteConstants.questionListPageRouteName);
              //   });
              // },
            ),
          );
        },
      ),
    );
  }
}
