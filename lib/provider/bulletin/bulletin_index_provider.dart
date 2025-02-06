// bulletin_index_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/bulletin_index_model.dart';
import '../../services/bulletin/bulletin_index_service.dart';

// final uniqueGroupNamesProvider = Provider<Set<String>>((ref) => {});

final selectedBulletinIndexIdProvider = StateProvider<int>((ref) {
  return 0;
});

final bulletinIndexModelProvider = StateNotifierProvider<
    BulletinIndexModelListNotifier, BulletinIndexModelList>((ref) {
  return BulletinIndexModelListNotifier();
});

final bulletinIndexServiceProvider = Provider<BulletinIndexService>((ref) {
  return BulletinIndexService();
});

final bulletinIndexSuccessProvider =
    StateNotifierProvider<BulletinIndexSuccessNotifier, bool>((ref) {
  return BulletinIndexSuccessNotifier(); // You'll need to create this notifier class
});

class BulletinIndexSuccessNotifier extends StateNotifier<bool> {
  BulletinIndexSuccessNotifier() : super(false); // Initialize with false

  void setEventSuccess(bool value) {
    state = value;
  }
}
