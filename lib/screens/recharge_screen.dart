import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/recharge/airtm_form.dart';
import 'package:gpay/screens/forms/recharge/deposit_form.dart';
import 'package:gpay/screens/forms/recharge/pay_safe_cash_form.dart';
import 'package:gpay/screens/forms/recharge/qr_form.dart';
import 'package:gpay/screens/forms/recharge/voucher_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> with WidgetsBindingObserver{

  //Variables
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  bool isProcessing = false;
  String paySafeUrl= '';
  var screenSize, screenWidth, screenHeight;

  _offScanning() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning',false);
  }
  @override
  void initState(){
    _offScanning();
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
          height: 80.0,
        ),
        title:  Text(
          S.of(context).loads,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Positioned(
              child: Column(
                children: [
                  Container(
                    child: TextButton(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset('images/icons/deposit_zelle_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            '${S.of(context).deposit} / Zelle',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DepositForm(),
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color(0XFF00B70D)
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(left: 20.0),
                    width: 325,
                    height: 70,
                  ),
                  Container(
                    child: TextButton(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset('images/icons/merchant_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                          Text(
                            '${S.of(context).merchant}s',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VoucherForm(),
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(0XFF00B70D)
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(left: 20.0),
                    width: 325,
                    height: 70,
                  ),
                  Container(
                    child: TextButton(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset('images/icons/qr_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            S.of(context).scanQr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QrForm(),
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(0XFF00B70D)
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(left: 20.0),
                    width: 325,
                    height: 80,
                  ),
                  Container(
                    child: TextButton(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset('images/icons/ps_cash_logo.png'),
                            height: 70.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 70.0,
                          ),
                          const Text(
                            'PaySafe:Cash',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> const PaySafeCashForm()
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(0XFF00B70D)
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(left: 20.0),
                    width: 325,
                    height: 70,
                  ),
                  Container(
                    child: TextButton(
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset('images/icons/airtm_icon.png'),
                            height: 70.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 70.0,
                          ),
                          const Text(
                            'AIRTM',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> const AirTmForm()
                          ),
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color(0XFF00B70D)
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(left: 20.0),
                    width: 325,
                    height: 70,
                  ),
                ],
              ),
              top: 10.0,
              left: (screenWidth - 325 ) / 2,
            ),
            Positioned(
              child: SizedBox(
                child: Image.asset('images/logos/gpay_blue_logo_87x40.png'),
              ),
              top: screenHeight - 150.0,
              left: (screenWidth - 87) / 2,
            ),
          ],
        ),
        height: screenHeight,
        width: screenWidth,
      ),
    );
  }
}
