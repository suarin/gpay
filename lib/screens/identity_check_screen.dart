import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/registration_success_response.dart';


class IdentityCheckScreen extends StatefulWidget {
  final RegistrationSuccessResponse? registrationSuccessResponse;
  const IdentityCheckScreen({Key? key, @required this.registrationSuccessResponse}) : super(key: key);

  @override
  _IdentityCheckScreenState createState() {
    return _IdentityCheckScreenState(registrationSuccessResponse: this.registrationSuccessResponse);
  }
}

class _IdentityCheckScreenState extends State<IdentityCheckScreen> {
  final RegistrationSuccessResponse? registrationSuccessResponse;
  _IdentityCheckScreenState({Key? key, @required this.registrationSuccessResponse});

  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    var url = 'https://bgipay.me/spa/xcmo/securew/mati_cproof.asp?CHolderID=${registrationSuccessResponse!.cHolderId}';

    return WebviewScaffold(
      url: url,
      withJavascript: true,
      withZoom: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
            'images/backgrounds/app_bar_header.png',
          fit: BoxFit.fill,
          height: 100,
        ),
        title:  Text(
          S.of(context).checkIdentity,
          style: const TextStyle(
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
