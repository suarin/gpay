import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PaySafeCashWebView extends StatefulWidget {
  final String? paySafeUrl;
  const PaySafeCashWebView({Key? key, @required this.paySafeUrl}) : super(key: key);

  @override
  _PaySafeCashWebViewState createState() {
    return _PaySafeCashWebViewState(paySafeUrl: this.paySafeUrl);
  }
}

class _PaySafeCashWebViewState extends State<PaySafeCashWebView> with WidgetsBindingObserver{
  final String? paySafeUrl;
  _PaySafeCashWebViewState({Key? key, @required this.paySafeUrl});
  var screenSize, screenWidth, screenHeight;

  _offScanning() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning',false);
  }

  @override
  void initState() {
    _offScanning();
    super.initState();
  }
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WebviewScaffold(
      url: paySafeUrl!,
      withJavascript: true,
      withZoom: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
          'images/backgrounds/app_bar_header.png',
          fit: BoxFit.fill,
          height: 80.0,
        ),
        title: const Text(
          'PaySafe:Cash',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
