import '/widgets/speaker_control.dart';
import 'package:flutter/material.dart';

import '../../views/book/home/home_book_topic.dart';
import 'bookmark_icon_button.dart';

Future<void> showInfoDialog(
  BuildContext context,
  var bookId,
  var topicHead,
  var topicIntro,
  int imageNos,
  // WidgetRef ref,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow.shade100,
        shadowColor: Colors.red,
        title: Text(
          topicHead,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            topicIntro,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        actions: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.read_more),
                  iconSize: 25,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeBookTopicPage(
                          book_id: bookId,
                          book_intro: topicIntro,
                          image_nos: imageNos,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.spatial_audio,
                    color: Colors.black,
                    size: 22,
                  ),
                  onPressed: () {
                    showTTSDialog(context, topicHead, topicIntro);
                  },
                ),
                buildBookmarkIconButton(
                  context,
                  bookId,
                  Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  iconSize: 25,
                  onPressed: () {
                    // await speakToMe.stopSpeaking();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
