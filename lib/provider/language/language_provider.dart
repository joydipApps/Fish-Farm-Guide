import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../translate/language_store.dart';
import '../../utils/local_shared_Storage.dart';

// Provider for LocalSharedStorage
final localSharedStorageProvider = Provider<LocalSharedStorage>((ref) {
  return LocalSharedStorage();
});

final languageProvider = FutureProvider<AsyncValue<String>>((ref) async {
  final localStorage = ref.read(localSharedStorageProvider);
  try {
    String languageCode = await localStorage.getLanguageCode();
    return AsyncValue.data(languageCode);
  } catch (error, stackTrace) {
    return AsyncValue.error(error, stackTrace);
  }
});

// Provider for language code
// final languageProvider = FutureProvider<String>((ref) async {
//   final localStorage = ref.read(localSharedStorageProvider);
//   String languageCode = await localStorage.getLanguageCode();
//   return languageCode;
// });
