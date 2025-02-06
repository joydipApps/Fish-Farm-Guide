import 'package:fishfarmguide_prod/models/consult/service/service_list_model.dart';
import 'package:fishfarmguide_prod/provider/consult/Service/service_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/show_progress_dialog.dart';

Future<void> fetchServiceListFunction(
  BuildContext context,
  WidgetRef ref,
) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final bool success = ref.watch(serviceListSuccessProvider);
    debugPrint('fetchServiceListFunction value: $success');

    if (!success) {
      debugPrint('fetchServiceListFunction:Fetching data');

      final List<ServiceListModel>? serviceList =
          await ref.read(serviceListServiceProvider).fetchServiceList(
                context,
              );

      if (serviceList != null && serviceList.isNotEmpty) {
        debugPrint(
            'fetchServiceListFunction:category List fetched successfully: ${serviceList.length} records');

        ref
            .read(serviceListModelNotifierProvider.notifier)
            .addServiceListModels(serviceList);
        debugPrint(
            'fetchServiceListFunction: list data added to Provider: $serviceList');

        ref
            .read(serviceListSuccessProvider.notifier)
            .setServiceListSuccess(true);
        debugPrint('fetchServiceListFunction: SuccessProvider set to true');
      } else {
        debugPrint('fetchServiceListFunction:data is null or empty');
      }
    } else {
      debugPrint('fetchServiceListFunction: list already fetched successfully');
    }
  } catch (e) {
    // Handle error
    debugPrint('fetchServiceListFunction:Error fetching  list: $e');
  } finally {
    // Stop loading
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
