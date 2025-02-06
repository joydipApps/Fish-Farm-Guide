import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/common_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({super.key});

  // Function to launch the phone dialer
  void _launchPhoneDialer(BuildContext context) async {
    const phoneNumber = '+917001302722';
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      var msg = 'Could not launch Phone Dialer with $phoneNumber';
      _showErrorDialog(context, msg, phoneNumber);
    }
  }

  void _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '917001302722';
    final uri = Uri.parse('https://wa.me/$phoneNumber');
    // final uri = Uri.parse('whatsapp://send?phone=$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      //throw 'Could not launch WhatsApp with $uri';
      var msg = 'Could not launch WhatsApp with $phoneNumber';
      _showErrorDialog(context, msg, phoneNumber);
    }
  }

  void _launchMail(BuildContext context) async {
    const emailId = 'b.banaspati1965@gmail.com';
    final uri = Uri.parse('mailto:$emailId');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      var msg = 'Could not launch Email with $emailId';
      _showErrorDialog(context, msg, emailId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
          context,
          'About Author',
          isIconBack: true,
          showBottomTabBar: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 60,

                  backgroundImage: AssetImage(
                      'assets/author/banaspatiBiswas.jpeg'), // Replace with your image path
                ),
                const SizedBox(height: 20),
                const Text(
                  'Mr. Banaspati Biswas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _launchPhoneDialer(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.phone,
                            color: Colors.blue.shade500,
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors
                                  .blue.shade500, // Customize the text color
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        _launchWhatsApp(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green.shade500,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'WhatsApp',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors
                                  .green.shade500, // Customize the text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _launchMail(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.envelope,
                            color: Colors.purple.shade900,
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Write a Mail',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purple.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Assistant Director of Fisheries, Govt. of West Bengal, Bharat. Eminent Fishery Expert in Inland Aquaculture having 37 years  Field Experience.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Awardee of Gopal Chandra Bhattarcharyya Smriti Puraskar of Department of Science & Technology, Govt. of West Bengal for unparalleled work in popularizing Science among people of Bengal and abroad for more than 20 years. He has innovated many uses of Fishery inputs in his non-conventional research, which are very popular among farmers and increase the productivity of fish.\n',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
}

Future<void> _showErrorDialog(
    BuildContext context, String msg, String copyText) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow.shade100,
        elevation: 10.0,
        shadowColor: Colors.red,
        title: const Text(
          'Information :',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(msg),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _copyToClipboard(context, copyText);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.yellow
                    .shade100), // Set the background color to yellow.shade200
                shadowColor: WidgetStateProperty.all<Color>(
                    Colors.red), // Set the background color to yellow.shade200
                elevation: WidgetStateProperty.all(
                    10.0), // Set the background color to yellow.shade200
              ),
              child: const Text('Copy and Close'),
            ),
          ],
        ),
      );
    },
  );
}

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  // displaySnackBar(context, 6, '$text copied to clipboard');
}
