// about_us_page.dart - checked
import 'package:flutter/material.dart';
import '../../widgets/common_app_bar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'About Us',
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
                'About Us',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to Fish farm guide, your go-to resource for information on fish farming for Indian sub-continent. We at Fish Farm guide are committed to assisting Indian fish farmers in their efforts to be successful.  With only a quick account creation, our app provides free access to an extensive number of fishery articles. We think that the secret to succeeding in the fisheries industry is knowledge by offering insightful advice and knowledge based on best scientific practices in Industry.  We enable fish farmers to increase yields and sustainably expand their companies. Join our group now to have access to a wealth of fisheries knowledge that will enable you to confidently navigate the seas of this business. Our goal is for you to succeed.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Fish is a water crop, if you cultivate it, the profit will be double.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Our methodology to achieve - Fish is a water crop, if you cultivate it, the profit is double.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'App ownership:  Prayas Fish Production Group, WB, India.\n',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Development & NGO partner  : Kaarva Foundation, WB, India.\n',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.justify,
              ),
              Text(
                'App developed by : IoTivity Communications Private Limited , Kolkata, India.',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
