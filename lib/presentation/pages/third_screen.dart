import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var widgets = rateShare(context);
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
    ));
  }

  final String url = "http://play.google.com/store/apps/details?id=";
  final String packageName = "com.android.chrome";

  List<Widget> rateShare(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(showDialogBtn(context));
    widgets.add(shareApp());
    widgets.add(openBrowserLink());
    return widgets;
  }

  Widget showDialogBtn(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return rateApp();
              });
        },
        child: Text("Rate App"));
  }

  Widget rateApp() => RatingDialog(
        initialRating: 1.0,

        title: const Text(
          'Rating Dialog',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // encourage your user to leave a high rating?
        message: const Text(
          'Tap a star to set your rating. Add more description here if you want.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        // your app's logo?

        image: const FlutterLogo(size: 100),
        submitButtonText: 'Submit',
        commentHint: 'Set your custom comment hint',
        onSubmitted: (response) {
          _launchUrl();
        },
      );

  Future _launchUrl() async {
    final Uri _url = Uri.parse(url + packageName);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget openBrowserLink() {
    return ElevatedButton(
        onPressed: () {
          launchWebLink();
        },
        child: Text("Open Link"));
  }

  Widget shareApp() => ElevatedButton(
      onPressed: () {
        Share.share('check out my website https://example.com');
      },
      child: Text("Share App"));

  void launchWebLink() async {
    Uri browserUrl;
    if (!await launchUrl(browserUrl = Uri.parse(
        "https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7"))) {
      throw Exception('Could not launch $browserUrl');
    }
  }
}
