import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/recharge/cash_app_qr_screen.dart';
import 'package:gpay/screens/forms/recharge/cash_app_request_form.dart';

class CashAppOptionsScreen extends StatefulWidget {
  const CashAppOptionsScreen({Key? key}) : super(key: key);

  @override
  _CashAppOptionsScreenState createState() => _CashAppOptionsScreenState();
}

class _CashAppOptionsScreenState extends State<CashAppOptionsScreen> {
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
          title: const Text(
            'CashApp',
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
                    child: ListView(
                      children: [
                        Container(
                          child: TextButton(
                            child: Text(
                              S.of(context).cashAppPay,
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
                                  builder: (context) => const CashAppQrScreen(),
                                ),
                              );
                            },
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFF00CAB2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          width: 300.0,
                          margin: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                        ),
                        Container(
                          child: TextButton(
                            child: Text(
                              S.of(context).cashAppPayRequest,
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
                                  builder: (context) =>
                                      const CashAppRequestForm(),
                                ),
                              );
                            },
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFF00CAB2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          width: 300.0,
                        ),
                      ],
                    ),
                    height: screenHeight,
                    width: 300,
                  ),
                  top: 50,
                  left: (screenWidth - 300) / 2,
                ),
              ],
            ),
          ),
          height: screenHeight,
          width: screenWidth,
        ));
  }
}
