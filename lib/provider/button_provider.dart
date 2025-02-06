import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonToggleStateNotifier extends StateNotifier<bool> {
  ButtonToggleStateNotifier(super.initialState);

  void toggle() {
    state = !state;
  }
}

final buttonToggleProviderFamily =
    StateNotifierProviderFamily<ButtonToggleStateNotifier, bool, String>(
  (ref, bookId) {
    return ButtonToggleStateNotifier(false);
  },
);
