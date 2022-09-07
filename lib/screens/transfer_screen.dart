import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/transfer/bank_transfer_form.dart';
import 'package:gpay/screens/forms/transfer/card_transfer_form.dart';
import 'package:gpay/screens/forms/transfer/gps_account_transfer_form.dart';
import 'package:gpay/screens/forms/transfer/mobile_payment_web_view.dart';
import 'package:gpay/screens/forms/transfer/virtual_card_transfer_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> with WidgetsBindingObserver{

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
          S.of(context).transfer,
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
                            child: Image.asset('images/icons/between_accounts_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            S.of(context).toGpsAccounts,
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
                            builder: (context) => const GpsAccountTransferForm(),
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
                            child: Image.asset('images/icons/between_cards_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                           S.of(context).toVisaCard,
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
                            builder: (context) => const CardTransferForm(),
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
                            child: Image.asset('images/icons/between_cards_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                           S.of(context).toVirtualCard,
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
                            builder: (context) => const VirtualCardTransferForm(),
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
                            child: Image.asset('images/icons/bank_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                           S.of(context).toUSBank,
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
                            builder: (context) => const BankTransferForm(),
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
                            child: Image.asset('images/icons/bank_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            S.of(context).toMobile,
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
                            builder: (context) => const MobilePaymentWebView(),
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
