import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/books_index_model.dart';
import '../../../provider/books/books_index_provider.dart';
import '../../../themes/custom_app_theme.dart';
import '../../../widgets/bookmark_icon_button.dart';
import '../../../widgets/read_status_widget.dart';
import '../../../widgets/show_info_dialog.dart';
import '../../../widgets/social_media.dart';
import 'home_book_topic.dart';
import '../../../widgets/speak_to_me.dart';

class HomeBookIndexPage extends ConsumerStatefulWidget {
  const HomeBookIndexPage({super.key});

  @override
  ConsumerState<HomeBookIndexPage> createState() => _HomeBookIndexState();
}

class _HomeBookIndexState extends ConsumerState<HomeBookIndexPage> {
  List<BookIndexModel> existingModelList = [];
  Map<String, bool> groupVisibility = {};
  final SpeakToMe speakToMe = SpeakToMe();
  bool buttonEnabled = true;

  @override
  Widget build(BuildContext context) {
    existingModelList = ref.read(bookIndexModelProvider).books.toList();

    return Theme(
      data: CustomAppTheme.themeData.copyWith(
        cardTheme: CustomAppTheme.themeData.cardTheme,
      ),
      child: Scaffold(
        body: GroupedListView<BookIndexModel, String>(
          elements: existingModelList,
          groupBy: (element) => element.groupName,
          groupSeparatorBuilder: (String groupByValue) => ListTile(
            title: Card(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.format_list_bulleted),
                          const SizedBox(width: 10),
                          Text(
                            groupByValue,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(groupVisibility[groupByValue] == true
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                    onPressed: () {
                      // Toggle the visibility of child items
                      setState(() {
                        groupVisibility[groupByValue] =
                            !(groupVisibility[groupByValue] ?? false);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          itemBuilder: (context, element) {
            return Visibility(
              visible: groupVisibility[element.groupName] == true,
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: ListTile(
                  title: Text(
                    '${element.bookId} - ${element.bookName}',
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildReadStatusWidget(element.bookId),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.info,
                              color: Colors.yellow.shade800,
                            ),
                            iconSize: 22,
                            onPressed: () async {
                              showInfoDialog(
                                  context,
                                  element.bookId,
                                  element.bookName,
                                  element.bookIntro,
                                  element.bookImageNos);
                            },
                          ),
                          buildShareIconButton(
                            context,
                            kColor: Colors.cyan.shade500,
                            kShareBody: element.bookIntro,
                            kShareSubject: element.bookName,
                          ),
                          buildBookmarkIconButton(
                            context,
                            element.bookId,
                            Colors.purple.shade200,
                          ),
                          IconButton(
                            icon: Icon(Icons.read_more,
                                color: Colors.green.shade600),
                            iconSize: 26,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeBookTopicPage(
                                    book_id: element.bookId,
                                    book_intro: element.bookIntro,
                                    image_nos: element.bookImageNos,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
