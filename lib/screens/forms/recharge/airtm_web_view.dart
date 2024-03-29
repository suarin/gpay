import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AirTmWebView extends StatefulWidget {
  final String? airTmUrl;
  const AirTmWebView({Key? key, @required this.airTmUrl}) : super(key: key);

  @override
  _AirTmWebViewState createState() {
    return _AirTmWebViewState(airTmUrl: this.airTmUrl);
  }
}

class _AirTmWebViewState extends State<AirTmWebView> {
  final String? airTmUrl;
  _AirTmWebViewState({Key? key, @required this.airTmUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
          'images/backgrounds/app_bar_header.png',
          fit: BoxFit.fill,
          height: 80.0,
        ),
        title: const Text(
          'AIRTM',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'VarealRoundRegular',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: WebView(
        initialUrl: airTmUrl,
      ),
    );
  }
}
