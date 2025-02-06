// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final expansionNotifierProvider =
//     StateNotifierProvider<ExpansionNotifier, Set<int>>(
//         (ref) => ExpansionNotifier());
//
//
// class ExpansionNotifier extends Notifier<int, Set<int>> {
//   ExpansionNotifier() : super(Set<int>());
//
//   void togglePanel(int index) {
//     state = {index};
//   }
//
//   bool isPanelExpanded(int index) {
//     return state.contains(index);
//   }
// }
