import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audio_session/audio_session.dart';

import '../utils/local_shared_Storage.dart';

class SpeakToMe {
  final FlutterTts flutterTts = FlutterTts();
  late AudioSession audioSession;

  bool continueReading = true;
  int currentChunkIndex = 0;
  bool isPlaying = false;

  SpeakToMe() {
    _configureTts();
    _initAudioSession();
  }

  Future<void> _configureTts() async {
    String languageCode = await LocalSharedStorage().getLanguageCode();
    await flutterTts.setLanguage(languageCode);
    // await flutterTts.setLanguage("bn");
    await flutterTts.setPitch(1.0);
  }

  Future<void> _initAudioSession() async {
    audioSession = await AudioSession.instance;
    await audioSession.configure(const AudioSessionConfiguration.music());
    audioSession.interruptionEventStream.listen((event) {
      if (event.begin) {
        // Handle audio interruptions here
      } else {
        // Handle audio resumptions here
      }
    });
  }

  Future<void> _releaseAudioSession() async {
    await audioSession.setActive(false);
  }

  Future<void> speakTopicText(String text) async {
    _configureTts();
    await _initAudioSession();

    const maxChunkSize = 2000;
    final textChunks = _splitTextIntoChunks(text, maxChunkSize);

    for (int chunkIndex = 0;
        chunkIndex < textChunks.length && continueReading;
        chunkIndex++) {
      final chunk = textChunks[chunkIndex];
      debugPrint('Reading chunk $chunkIndex: $chunk');

      try {
        isPlaying = true;
        await flutterTts.speak(chunk);
        await flutterTts.awaitSpeakCompletion(true); // Wait for TTS to complete
        debugPrint('TTS playback completed for chunk $chunkIndex');
      } catch (e) {
        debugPrint('TTS playback error for chunk $chunkIndex: $e');
      } finally {
        isPlaying = false;
      }
    }

    currentChunkIndex = 0; // Reset to 0 for the next time

    if (!continueReading) {
      continueReading = true;
      _configureTts();
      await _releaseAudioSession();
      debugPrint('All chunks read, TTS state reset');
    }
  }

  List<String> _splitTextIntoChunks(String text, int maxChunkSize) {
    final List<String> chunks = [];
    int startIndex = 0;

    while (startIndex < text.length) {
      int endIndex = startIndex + maxChunkSize;
      endIndex = endIndex > text.length ? text.length : endIndex;

      final chunk = text.substring(startIndex, endIndex);
      chunks.add(chunk);

      startIndex = endIndex;
    }

    return chunks;
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    isPlaying = false;

    continueReading = false;
    await _releaseAudioSession();
  }
}
