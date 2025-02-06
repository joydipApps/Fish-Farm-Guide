// developer_info_page.dart - checked - not published
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/common_app_bar.dart';

class DeveloperInfoPage extends StatelessWidget {
  final String linkedInURL = "https://in.linkedin.com/in/joydipshome";

  const DeveloperInfoPage({super.key});

  _launchLinkedInURL() async {
    final Uri uri = Uri.parse(linkedInURL);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch LinkedIn URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'Developed By:',
        isIconBack: true,
        showBottomTabBar: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name : Joydip Shome',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Phone No : +91 9831077172',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: _launchLinkedInURL,
              child: const Text(
                'LinkedIn: Joydip Shome',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue, // Set the text color to blue
                  decoration:
                      TextDecoration.underline, // Add an underline to the text
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
