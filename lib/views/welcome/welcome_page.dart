import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../provider/welcome_button_provider.dart';
import '../../routes/app_route_constants.dart';
import '../../services/data_store/box_service.dart';
import '../book/home/fetch_book_buletin_data.dart';
import '../../services/consult/question/fetch_queston_category_list_function.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final String baseImageName = 'assets/images/fish_book';
  final int numberOfImages = 48;
  late String currentImage;

  @override
  void initState() {
    super.initState();
    // Initialize currentImage with a random image on page load
    currentImage = getRandomImage();
  }

  String getRandomImage() {
    final random = Random();
    final randomIndex = random.nextInt(numberOfImages) + 1;
    debugPrint('random no $randomIndex');
    return '$baseImageName$randomIndex.jpg';
  }

  void changeImage() {
    setState(() {
      // Change to a new random image
      currentImage = getRandomImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Opacity(
            opacity: 0.7,
            child: Image.asset(
              'assets/wallpaper/fish_back.jpg',
              fit: BoxFit.cover,
              width: screenWidth,
              height: imageHeight,
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                child: WelcomeScreen(
                  title:
                      'Fish Farm Guide\nFlexible Learning for\n Successful Aquaculture',
                  description:
                      'Anywhere, anytime. The time is at your discretion so learn whenever you want.',
                  imageAsset: currentImage, // Pass the current image
                  onImageTap: changeImage, // Pass the changeImage function
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;
  final VoidCallback onImageTap; // Callback for image change

  const WelcomeScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // const double screenWidth = 30;
    const double aspectRatio = 4 / 3;
    final double imageHeight = screenWidth / aspectRatio;
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: onImageTap, // Change image on tap
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Image.asset(
                      imageAsset, // Use the passed image asset
                      height: imageHeight,
                      width: screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black, // Shadow color
                      blurRadius: 2, // Blur radius
                      offset: Offset(1, 1), // Shadow offset
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black, // Shadow color
                      blurRadius: 2, // Blur radius
                      offset: Offset(1, 1), // Shadow offset
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10.0),
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(loadingStateProvider);

                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            ref.read(menuStateProvider.notifier).state = 1;
                            fetchBookBulletinData(context, ref).then((_) {
                              GoRouter.of(context)
                                  .goNamed(AppRouteConstants.homeRouteName);
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      "Open Guide - Start Reading 📚",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(loadingStateProvider);
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            ref.read(menuStateProvider.notifier).state = 2;
                            fetchQuestionCategoryListFunction(context, ref)
                                .then((_) {
                              GoRouter.of(context).goNamed(
                                  AppRouteConstants.homeConsultPageRouteName);
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      "Meet Experts - Ask Question 🤓",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  await BoxService().closeBookmarkBox();
                  await Hive.close();
                  debugPrint("Hive Database closed");
                  SystemNavigator.pop();
                },
                child: Text(
                  'Close Guide - Go Fishing 🎣',
                  style: TextStyle(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
