import 'package:fishfarmguide_prod/models/consult/experts/sme_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/consult/expert/sme_model_service.dart';

final smeModelProvider =
    StateNotifierProvider<SMEModelListNotifier, List<SMEModel>>((ref) {
  return SMEModelListNotifier();
});

final smeModelServiceProvider = Provider<SMEModelService>((ref) {
  return SMEModelService();
});

final smeModelSuccessProvider =
    StateNotifierProvider<SMEModelSuccessNotifier, bool>((ref) {
  return SMEModelSuccessNotifier(); // You'll need to create this notifier class
});

class SMEModelSuccessNotifier extends StateNotifier<bool> {
  SMEModelSuccessNotifier() : super(false); // Initialize with false

  void setSMEModelSuccess(bool value) {
    state = value;
  }
}
