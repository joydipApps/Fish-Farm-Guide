import 'package:fishfarmguide_prod/models/consult/experts/sme_model.dart';
import 'package:fishfarmguide_prod/models/consult/question/question_category_list.dart';
import 'package:fishfarmguide_prod/provider/consult/experts/sme_provider.dart';
import 'package:fishfarmguide_prod/provider/consult/question/question_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/welcome_button_provider.dart';
import '../../../utils/show_progress_dialog.dart';

Future<void> fetchSMEListFunction(
  BuildContext context,
  WidgetRef ref,
) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    // Fetch location List data
    final bool success = ref.watch(smeModelSuccessProvider);
    debugPrint('fetchSMEListFunction value: $success');

    if (!success) {
      debugPrint('fetchSMEListFunction:Fetching data');

      final List<SMEModel>? smeList =
          await ref.read(smeModelServiceProvider).fetchSMEModelData(
                context,
              );

      if (smeList != null && smeList.isNotEmpty) {
        debugPrint(
            'fetchSMEListFunction:category List fetched successfully: ${smeList.length} records');

        ref.read(smeModelProvider.notifier).addSMEModels(smeList);
        debugPrint(
            'fetchSMEListFunction: list data added to Provider: $smeList');

        ref.read(smeModelSuccessProvider.notifier).setSMEModelSuccess(true);
        debugPrint('fetchSMEListFunction: SuccessProvider set to true');
      } else {
        debugPrint('fetchSMEListFunction:data is null or empty');
      }
    } else {
      debugPrint('fetchSMEListFunction: list already fetched successfully');
    }
  } catch (e) {
    // Handle error
    debugPrint('fetchSMEListFunction:Error fetching  list: $e');
  } finally {
    // Stop loading
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
