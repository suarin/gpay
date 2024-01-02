import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/login_success_response.dart';
import 'package:gpay/screens/forms/password_recovery_form.dart';
import 'package:gpay/screens/forms/web_pin_form.dart';
import 'package:gpay/screens/startup_screen.dart';
import 'package:gpay/widgets/nav_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({Key? key}) : super(key: key);

  @override
  _PrincipalScreenState createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen>
    with WidgetsBindingObserver {
  //Variables
  var screenSize, screenWidth, screenHeight;
  String clientName = '0';
  String cardNo = '0000000000000000';
  String currency = '';
  String balance = '';
  String userID = '';
  String CHolderID = '';

  //Obtain User Data
  _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    LoginSuccessResponse loginSuccessResponse = LoginSuccessResponse(
        errorCode: 0,
        cHolderID: prefs.getInt('cHolderID'),
        userName: prefs.getString('userName'),
        cardNo: prefs.getString('cardNo'),
        currency: prefs.getString('currency'),
        balance: prefs.getString('balance'));
    setState(() {
      clientName = loginSuccessResponse.userName.toString();
      cardNo = loginSuccessResponse.cardNo.toString();
      currency = loginSuccessResponse.currency.toString();
      balance = loginSuccessResponse.balance.toString();
      userID = prefs.getString('userID').toString();
      CHolderID = loginSuccessResponse.cHolderID.toString();
    });
  }

  //Close app

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    Object? nowScanning = prefs.get('isScanning');
    if (nowScanning == false) {
      _cleanPreferences();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const StartupScreen()));
    }
  }

  //Clean persistent user data
  _cleanPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cHolderID', 0);
    await prefs.setString('userID', '');
    await prefs.setString('userName', '');
    await prefs.setString('cardNo', '');
    await prefs.setString('currency', '');
    await prefs.setString('balance', '');
    await prefs.setBool('isScanning', false);
  }

  //Set Scanning off
  _offScanning() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning', false);
  }

  //Launch Cancel Url
  Future<void> _launchInBrowser() async {
    String url =
        'https://gpspay.io/spa/xcmo/securew/customer_cancel_request.asp?CHolderID=$CHolderID';
    if (!await launch(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        _logOut();
        break;

      case AppLifecycleState.resumed:
        _logOut();
        break;

      case AppLifecycleState.inactive:
        _logOut();
        break;

      case AppLifecycleState.detached:
        _logOut();
        break;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _offScanning();
    _getUserData();
    super.initState();
  }

  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Image.asset(
          'images/backgrounds/app_bar_header.png',
          fit: BoxFit.fill,
          height: 150.0,
        ),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      child: SizedBox(
                        child: Image.asset(
                            'images/logos/gpay_white_logo_271x125.png'),
                        width: 125,
                      ),
                      right: 10,
                      top: 20,
                    ),
                    Positioned(
                      child: SizedBox(
                        child:
                            Image.asset('images/icons/contact_less_gold.png'),
                        width: 40.0,
                      ),
                      right: 15,
                      top: 60,
                    ),
                    Positioned(
                      child: SizedBox(
                        child: Image.asset('images/icons/chip_gold.png'),
                        width: 40.0,
                      ),
                      top: 60,
                      left: 25,
                    ),
                    Positioned(
                      child: Text(
                        clientName.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'VarealRoundRegular',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      top: 100,
                      left: 20,
                    ),
                    Positioned(
                      child: Text(
                        '${cardNo.substring(0, 4)} ${cardNo.substring(4, 8)}  ${cardNo.substring(8, 12)}  ${cardNo.substring(12, 16)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'VarealRoundRegular',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                        ),
                      ),
                      top: 130,
                      left: 20,
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    image: AssetImage(
                        'images/backgrounds/card_blue_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 190,
                width: 325,
              ),
              left: (screenWidth - 325) / 2,
              top: 5.0,
            ),
            Positioned(
              child: SizedBox(
                child: Row(
                  children: [
                    Container(
                      child: const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xFF00CAB2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      margin: const EdgeInsets.only(right: 20.0),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      child: Text(
                        '$currency $balance',
                        style: const TextStyle(
                            color: Color(0XFF01ACCA),
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      width: 150.0,
                    ),
                  ],
                ),
                width: 200,
              ),
              top: 225.0,
              left: 20,
            ),
            Positioned(
              child: SizedBox(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        clientName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xFF00CAB2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      child: Text(
                        userID.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'VarelaRoundRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0XFF01ACCA),
                        ),
                      ),
                      width: 150.0,
                    ),
                  ],
                ),
                width: 200,
              ),
              top: 275.0,
              left: 20,
            ),
            Positioned(
              child: Column(
                children: [
                  Container(
                    child: TextButton(
                      child: Text(
                        S.of(context).resetWebPin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'VarelaRoundRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WebPinForm(),
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                        color: Color(0xFF00CAB2),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    width: 300,
                  ),
                  Container(
                    child: TextButton(
                      child: Text(
                        S.of(context).changepassword,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordRecoveryForm(),
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                        color: Color(0xFF00CAB2),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    width: 300.0,
                  ),
                  Container(
                    child: TextButton(
                      child: Text(
                        S.of(context).cancelAccount,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      onPressed: () {
                        _launchInBrowser();
                      },
                    ),
                    decoration: const BoxDecoration(
                        color: Color(0xFF00CAB2),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    width: 300.0,
                  ),
                ],
              ),
              top: 325,
              left: (screenWidth - 300) / 2,
            ),
            Positioned(
              child: SizedBox(
                child: Image.asset('images/logos/gpay_blue_logo_87x40.png'),
                width: 87,
              ),
              top: screenHeight - 150.0,
              left: (screenWidth - 87) / 2,
            ),
          ],
        ),
        height: screenHeight,
        width: screenWidth,
      ),
      drawer: const NavDrawer(),
    );
  }
}
