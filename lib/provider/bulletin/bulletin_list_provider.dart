// bulletin_List_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/bulletin_list_model.dart';
import '../../services/bulletin/bulletin_list_service.dart';

final selectedBulletinIdProvider = StateProvider<int>((ref) {
  return 0;
});

final bulletinListModelProvider =
    StateNotifierProvider<BulletinListModelListNotifier, BulletinListModelList>(
        (ref) {
  return BulletinListModelListNotifier();
});

final bulletinListServiceProvider = Provider<BulletinListService>((ref) {
  return BulletinListService();
});

final bulletinListSuccessProvider =
    StateNotifierProvider<BulletinListSuccessNotifier, Map<int, bool>>((ref) {
  return BulletinListSuccessNotifier(); // You'll need to create this notifier class
});

class BulletinListSuccessNotifier extends StateNotifier<Map<int, bool>> {
  BulletinListSuccessNotifier() : super({});

  void setEventSuccess(int indexId, bool value) {
    state = {...state, indexId: value};
  }
}
