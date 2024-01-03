import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/recharge/pay_safe_cash_form.dart';
import 'package:gpay/screens/forms/recharge/pay_safe_deposit_request_form.dart';

class PaySafeCashScreenOptions extends StatefulWidget {
  const PaySafeCashScreenOptions({Key? key}) : super(key: key);

  @override
  _PaySafeCashScreenOptionsState createState() =>
      _PaySafeCashScreenOptionsState();
}

class _PaySafeCashScreenOptionsState extends State<PaySafeCashScreenOptions> {
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
            'PaySafe Cash',
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
                              S.of(context).paySafeCodeRequest,
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
                                  builder: (context) => const PaySafeCashForm(),
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
                              S.of(context).depositRequest,
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
                                      const PaySafeCodeRequestForm(),
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
