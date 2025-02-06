// //speech_button_provider.dart
// todo delete
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class SpeechToggleStateNotifier extends StateNotifier<bool> {
//   SpeechToggleStateNotifier(bool initialState) : super(initialState);
//
//   void updateState(bool newState) {
//     state = newState;
//   }
//
//   void toggle() {
//     state = !state;
//   }
// }
//
// final isPlayingProviderFamily =
//     StateNotifierProviderFamily<SpeechToggleStateNotifier, bool, String>(
//         (ref, bookId) {
//   return SpeechToggleStateNotifier(false);
// });
