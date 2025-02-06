import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider =
    StateNotifierProvider<CurrentPageNotifier, int>((ref) {
  return CurrentPageNotifier();
});

class CurrentPageNotifier extends StateNotifier<int> {
  CurrentPageNotifier() : super(0);

  void updateCurrentPage(int page) {
    state = page;
  }
}
