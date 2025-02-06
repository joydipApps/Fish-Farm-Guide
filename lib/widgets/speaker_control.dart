// speaker_control.dart - checked.
import 'dart:async';
import 'package:flutter/material.dart';
import 'speak_to_me.dart';

void showTTSDialog(BuildContext context, String topicHead, String topicIntro) {
  showDialog(
    context: context,
    builder: (context) {
      return TTSDialog(
        topicHead: topicHead,
        topicIntro: topicIntro,
      );
    },
  );
}

class TTSDialog extends StatefulWidget {
  final String topicHead;
  final String topicIntro;

  const TTSDialog(
      {super.key, required this.topicHead, required this.topicIntro});

  @override
  State<TTSDialog> createState() => _TTSDialogState();
}

class _TTSDialogState extends State<TTSDialog> {
  final SpeakToMe speakToMe = SpeakToMe();

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
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AlertDialog(
              backgroundColor: Colors.yellow.shade100,
              shadowColor: Colors.red,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await speakToMe.speakTopicText(
                              "${widget.topicHead}, ${widget.topicIntro}");
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
                              color:
                                  Colors.green.shade700, // Set the icon color
                            ),
                            const SizedBox(
                                width:
                                    5), // Adjust the spacing between icon and text
                            Text(
                              'Play',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    Colors.green.shade700, // Set the text color
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () async {
                          await speakToMe.stopSpeaking();
                          if (context.mounted) Navigator.of(context).pop();
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
          )
        ],
      ),
    );
  }
}
