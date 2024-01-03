import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/registration_success_response.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationResultsScreen extends StatefulWidget {
  final RegistrationSuccessResponse? registrationSuccessResponse;
  const RegistrationResultsScreen(
      {Key? key, @required this.registrationSuccessResponse})
      : super(key: key);

  @override
  _RegistrationResultsScreenState createState() {
    return _RegistrationResultsScreenState(
        registrationSuccessResponse: this.registrationSuccessResponse);
  }
}

class _RegistrationResultsScreenState extends State<RegistrationResultsScreen> {
  final RegistrationSuccessResponse? registrationSuccessResponse;
  _RegistrationResultsScreenState(
      {Key? key, @required this.registrationSuccessResponse});

  Future<void> _launchInBrowser() async {
    String url =
        'https://gpspay.io/spa/xcmo/securew/mati_cproof.asp?CHolderID=${registrationSuccessResponse!.cHolderId}';
    if (!await launch(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
          'images/backgrounds/app_bar_header.png',
          fit: BoxFit.fill,
          height: 150.0,
        ),
        title: Text(
          S.of(context).credentials,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 25.0,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/backgrounds/app_background.jpg"),
              fit: BoxFit.cover),
        ),
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text('GUARDA ESTOS DATOS, SON PARA TU USO EXCLUSIVAMENTE'),
            ),
            Row(
              children: [
                SizedBox(
                  height: 30.0,
                  child: Text(
                    S.of(context).accountNumber,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  width: 150.0,
                ),
                SizedBox(
                  height: 30.0,
                  child: Text(registrationSuccessResponse!.cardNo.toString()),
                  width: 150.0,
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 30.0,
                  child: Text(
                    S.of(context).userId,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  width: 150.0,
                ),
                SizedBox(
                  height: 30.0,
                  child: Text(registrationSuccessResponse!.userId.toString()),
                  width: 150.0,
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 30.0,
                  child: Text(
                    S.of(context).password,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  width: 150.0,
                ),
                SizedBox(
                  height: 30.0,
                  child: Text(registrationSuccessResponse!.password.toString()),
                  width: 150.0,
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 30.0,
                  child: Text(
                    S.of(context).authorization,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  width: 150.0,
                ),
                SizedBox(
                  height: 30.0,
                  child: Text(registrationSuccessResponse!.authno.toString()),
                  width: 150.0,
                )
              ],
            ),
            Container(
              child: TextButton(
                child: Text(
                  S.of(context).checkIdentity,
                  style: const TextStyle(
                    color: Color(0xFF194D82),
                    fontFamily: 'VarelaRoundRegular',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => {_launchInBrowser()},
              ),
              decoration: const BoxDecoration(
                  color: Color(0xFF00FFD5),
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
