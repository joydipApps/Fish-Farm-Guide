import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingStateProvider = StateProvider<bool>((ref) => false);
final menuStateProvider = StateProvider<int>((ref) => 0);

final welcomeButtonStateProvider =
    StateNotifierProvider<WelcomeButtonNotifier, bool>(
  (_) => WelcomeButtonNotifier(),
);

class WelcomeButtonNotifier extends StateNotifier<bool> {
  WelcomeButtonNotifier() : super(true);

  void disableButton() {
    state = false;
    // Re-enable the button after a certain duration (e.g., 2 seconds)
    Future.delayed(const Duration(seconds: 2), () {
      enableButton();
    });
  }

  void enableButton() {
    state = true;
  }
}
