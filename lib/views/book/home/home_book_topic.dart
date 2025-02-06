import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/books_topic_model.dart';
import '../../../provider/books/books_image_provider.dart';
import '../../../services/data_store/book_read_manager.dart';
import '../../../themes/custom_app_theme.dart';
import '../../../widgets/bookmark_icon_button.dart';
import '../../../widgets/common_app_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../provider/books/books_topic_provider.dart';
import '../../../widgets/convert_html_to_text.dart';
import '../../../widgets/show_book_images.dart';
import '../../../widgets/social_media.dart';
import '../../../widgets/speaker_control.dart';

class HomeBookTopicPage extends ConsumerStatefulWidget {
  const HomeBookTopicPage({
    super.key,
    required this.book_id,
    required this.book_intro,
    required this.image_nos,
  });
  final String book_id;
  final String book_intro;
  final int image_nos;

  @override
  _HomeBookTopicState createState() => _HomeBookTopicState();
}

class _HomeBookTopicState extends ConsumerState<HomeBookTopicPage> {
  late Future<BookTopicModel?> _future;
  // revoke if required
  // bool _isDataLoading = true;

  String textToSpeak = '',
      topic_head = '',
      topic_intro = '',
      shareIntro = '',
      shareBookName = '',
      textToConvert = '';
  double _zoomLevel = 1.0;
  bool _fontSizeNormal = true;

  @override
  void initState() {
    super.initState();
    _future = _fetchData();
    _handleMarkAsRead();
    if (widget.image_nos > 0) {
      _fetchImageListData();
    }
  }

  // get Image data
  Future<void> _fetchImageListData() async {
    final bookId = widget.book_id;
    final imageNos = widget.image_nos;

    debugPrint("Image - Book Id $bookId, Images: $imageNos");

    try {
      final successNotifier = ref.read(bookImageSuccessProvider.notifier);

      if (successNotifier.successMap[bookId] == true) {
        return;
      }

      final newImageList = await ref
          .read(bookImageServiceProvider)
          .getBookImageData(bookId: bookId);

      if (newImageList != null) {
        ref
            .read(bookImageModelProvider.notifier)
            .addBookImageModels(newImageList);

        //successNotifier.setEventSuccess(bookId, true);
        ref
            .read(bookImageSuccessProvider.notifier)
            .setEventSuccess(bookId, true);
      }
    } catch (error) {
      // Handle the error, log it, or show a relevant message to the user
    }
  }

  // Function to handle marking the book as read
  void _handleMarkAsRead() async {
    final bookReadManager = BookReadManager();
    final bookId = widget.book_id;

    try {
      await bookReadManager.addBookRead(bookId: bookId);
    } catch (e) {
      debugPrint('5 Error marking book as read: $e');
    }
  }

  Future<BookTopicModel?> _fetchData() async {
    try {
      debugPrint(' Checking if the model is already available');
      final existingModel = ref.read(bookTopicModelProvider);

      if (existingModel?.bookId == widget.book_id) {
        // revoke if required
        // setState(() {
        //   _isDataLoading = false;
        // });
        // debugPrint('2 Model is already available. No need to fetch again.');
        return existingModel;
      }

      // Fetch data using the service provider
      // debugPrint('3 Fetching data using the service provider');
      final newBookTopic = await ref
          .read(bookTopicServiceProvider)
          .getBookTopicData(bookId: widget.book_id);

      // Check if new data is valid
      if (newBookTopic?.bookId.isNotEmpty == true &&
          newBookTopic is BookTopicModel) {
        // debugPrint('4 Fetched data: ${newBookTopic.bookId}');
        // Update providers and UI
        ref.read(bookTopicModelProvider.notifier).addBookTopic(newBookTopic);
        ref.read(bookTopicSuccessProvider.notifier).setEventSuccess(true);

        try {
          topic_head = convertHtmlToText(newBookTopic.bookName);
          topic_intro = convertHtmlToText(newBookTopic.bookDetails);
        } catch (e) {
          // debugPrint("Error during text-to-speech: $e");
        }

        shareIntro = widget.book_intro;
        shareBookName = newBookTopic.bookName;

        return newBookTopic;
      } else {
        // debugPrint('5 Invalid data received for book_id: ${widget.book_id}');
        ref.read(bookTopicSuccessProvider.notifier).setEventSuccess(false);
        return null;
      }
    } on FormatException catch (e) {
      debugPrint('6 Error parsing response: $e');
      ref.read(bookTopicSuccessProvider.notifier).setEventSuccess(false);
      return null;
    } catch (e) {
      ref.read(bookTopicSuccessProvider.notifier).setEventSuccess(false);
      return null;
    } finally {
      debugPrint('9 Setting _isDataLoading to false');
      if (mounted) {
        setState(() {
          //revoke if required
          // _isDataLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, 'Article',
          isIconBack: true, showBottomTabBar: false),
      body: Theme(
        data: CustomAppTheme.themeData.copyWith(
          cardTheme: CustomAppTheme.themeData.cardTheme,
        ),
        child: FutureBuilder<BookTopicModel?>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text('Error loading data'));
            } else {
              var bookModel = snapshot.data!;

              debugPrint('Book Model = snapshot');

              // start

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            bookModel.bookName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18 * _zoomLevel,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Html(
                            data:
                                '<div style="text-align: justify; text-justify: inter-word; font-size: ${16 * _zoomLevel}px;">${bookModel.bookDetails}</div>',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Theme(
        data: CustomAppTheme.themeData.copyWith(
          cardTheme: CustomAppTheme.themeData.cardTheme,
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          child: Builder(
            builder: (context) {
              return Card(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.view_carousel_sharp,
                            color: widget.image_nos > 0
                                ? Colors.lightGreen.shade600
                                : Colors.black),
                        iconSize: 22,
                        onPressed: widget.image_nos > 0
                            ? () {
                                showCarouselDialog(
                                    context, widget.book_id, ref);
                              }
                            : null,
                        tooltip: widget.image_nos > 0
                            ? null
                            : 'No images for this article',
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.spatial_audio,
                          color: Colors.black,
                          size: 22,
                        ),
                        onPressed: () {
                          showTTSDialog(context, topic_head, topic_intro);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                            _fontSizeNormal
                                ? Icons.zoom_out_map
                                : Icons.zoom_in_map,
                            color: _fontSizeNormal
                                ? Colors.black
                                : Colors.amber.shade800),
                        iconSize: 25,
                        onPressed: () {
                          setState(() {
                            _fontSizeNormal = !_fontSizeNormal;
                            _zoomLevel = _fontSizeNormal ? 1.0 : 1.5;
                          });
                        },
                      ),
                      buildBookmarkIconButton(
                        context,
                        widget.book_id,
                        Colors.black,
                      ),
                      buildShareIconButton(
                        context,
                        kColor: Colors.black,
                        kShareBody: shareIntro,
                        kShareSubject: shareBookName,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
