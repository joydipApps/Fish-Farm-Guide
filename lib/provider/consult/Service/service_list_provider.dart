import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/consult/service/service_list_model.dart';
import '../../../services/consult/service/service_list_service.dart';

final serviceListModelNotifierProvider =
    StateNotifierProvider<ServiceListModelNotifier, List<ServiceListModel>>(
  (ref) => ServiceListModelNotifier(),
);

final serviceListServiceProvider = Provider<ServiceListService>((ref) {
  return ServiceListService();
});

final serviceListSuccessProvider =
    StateNotifierProvider<ServiceListSuccessNotifier, bool>((ref) {
  return ServiceListSuccessNotifier(); // You'll need to create this notifier class
});

class ServiceListSuccessNotifier extends StateNotifier<bool> {
  ServiceListSuccessNotifier() : super(false); // Initialize with false

  void setServiceListSuccess(bool value) {
    state = value;
  }
}
