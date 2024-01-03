import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';

class CashAppQrScreen extends StatefulWidget {
  const CashAppQrScreen({Key? key}) : super(key: key);

  @override
  _CashAppQrScreenState createState() => _CashAppQrScreenState();
}

class _CashAppQrScreenState extends State<CashAppQrScreen> {
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
            S.of(context).cashAppPay,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'VarealRoundRegular',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SizedBox(
          child: SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  'images/backgrounds/app_background.jpg',
                  height: screenHeight,
                  width: screenWidth,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  child: SizedBox(
                    width: screenWidth * 0.95,
                    child: Image.asset('images/icons/cash_app_logo.PNG'),
                  ),
                  top: 50,
                  left: (screenWidth - (screenWidth * 0.95)) / 2,
                ),
              ],
            ),
          ),
          height: screenHeight,
          width: screenWidth,
        ));
  }
}
