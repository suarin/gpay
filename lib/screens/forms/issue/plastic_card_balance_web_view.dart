import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlasticCardWebView extends StatefulWidget {
  const PlasticCardWebView({Key? key}) : super(key: key);

  @override
  _PlasticCardWebViewState createState() => _PlasticCardWebViewState();
}

class _PlasticCardWebViewState extends State<PlasticCardWebView> {
  String url = 'https://eptravelcards.com/Account/Balance';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
          'images/backgrounds/app_bar_header.png',
          fit: BoxFit.fill,
          height: 150.0,
        ),
        title: const Text(
          'Balance',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'VarealRoundRegular',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
