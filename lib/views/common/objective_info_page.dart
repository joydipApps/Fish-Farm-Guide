// objective_info_page.dart - checked
import 'package:flutter/material.dart';
import '../../widgets/common_app_bar.dart';

class ObjectiveInfoPage extends StatelessWidget {
  const ObjectiveInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'Fish Farm Guide',
        isIconBack: true,
        showBottomTabBar: false,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Objective of the App:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The primary goal of the fish farm guide app is to disseminate valuable knowledge to farmers.\n Specifically, the app aims to provide farmers with insights into best practices in fish farming.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              FeatureItem(
                  title: 'Knowledge Dissemination',
                  description:
                      'The app serves as a platform to share information and expertise with farmers. \nBy leveraging the app, farmers can gain access to a wealth of knowledge related to effective fish farming techniques.'),
              FeatureItem(
                  title: 'Cost-Effective Farming',
                  description:
                      'One of the key features of the app is to guide farmers in adopting cost-effective farming methods.\nThe app emphasizes techniques that not only enhance productivity but also contribute to overall cost efficiency in fish farming.'),
              FeatureItem(
                  title: 'Profitability Enhancement',
                  description:
                      'An integral aspect of the app is to contribute to the profitability of fish farms.\nThrough the implementation of recommended practices, farmers can expect to see increased profitability in their fish farming ventures.'),
              FeatureItem(
                  title: 'User-Friendly Interface',
                  description:
                      'To ensure accessibility for a diverse user base, the app is designed with a user-friendly interface.\nThe user interface is intuitive, making it easy for farmers to navigate and access relevant information.'),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
