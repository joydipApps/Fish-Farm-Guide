// speaker_control.dart - checked.
import 'dart:async';
import 'package:flutter/material.dart';
import 'custom_music_visualizer.dart';
import 'speak_to_me.dart';

void showTTSDialog(
    BuildContext context, String topicHead, String topicIntro) {
  showDialog(
    context: context,
    builder: (context) {
      return TTSDialog(
        topic_head: topicHead,
        topic_intro: topicIntro,
      );
    },
  );
}

class TTSDialog extends StatefulWidget {
  final String topic_head;
  final String topic_intro;

  const TTSDialog({super.key, required this.topic_head, required this.topic_intro});

  @override
  State<TTSDialog> createState() => _TTSDialogState();
}

class _TTSDialogState extends State<TTSDialog> {
  final SpeakToMe speakToMe = SpeakToMe();

  late Timer _timer = Timer(Duration.zero, () {});
  Duration _elapsedTime = Duration.zero;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
      });
    });
  }

  void _resetTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _elapsedTime = Duration.zero;
    });
    _startTimer();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final SpeakToMe speakToMe = SpeakToMe();

    return PopScope(
      canPop: true,
      onPopInvoked: (shouldPop) async {
        if (shouldPop) {
          await speakToMe.stopSpeaking();
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      child: AlertDialog(
        backgroundColor: Colors.yellow.shade100,
        shadowColor: Colors.red,
        title: Text(
          widget.topic_head,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100, // Adjust the height as needed
                    color: Colors.grey.shade500,
                    child: CustomMusicVisualizer(),
                  ),
                  Positioned(
                    bottom: 2.0,
                    right: 8.0,
                    child: Text(
                      _elapsedTime
                          .toString()
                          .split('.')
                          .first, // Using toString directly
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
                // child:
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _resetTimer();
                      await speakToMe.speakTopicText(
                          "${widget.topic_head}, ${widget.topic_intro}");
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      shadowColor: Colors.yellowAccent,
                      backgroundColor:
                          Colors.yellow.shade100, // Set the button color
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 22,
                          color: Colors.green.shade700, // Set the icon color
                        ),
                        const SizedBox(
                            width:
                                5), // Adjust the spacing between icon and text
                        Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green.shade700, // Set the text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () async {
                      await speakToMe.stopSpeaking();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      shadowColor: Colors.yellowAccent,
                      backgroundColor:
                          Colors.yellow.shade100, // Set the button color
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.stop,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        SizedBox(
                            width:
                                5), // Adjust the spacing between icon and text
                        Text(
                          'Stop',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
