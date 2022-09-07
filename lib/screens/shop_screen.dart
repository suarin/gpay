import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/shop/shop_form.dart';
import 'package:gpay/screens/forms/shop/transaction_form.dart';
import 'package:gpay/screens/forms/shop/visa_transactions_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with WidgetsBindingObserver{

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
          S.of(context).shop,
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
                            child: Image.asset('images/icons/qr_icon.png'),
                            height: 25.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 25.0,
                          ),
                           Text(
                            S.of(context).scanQr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopForm(),
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
                            child: Image.asset('images/icons/card_icon.png'),
                            height: 25.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 25.0,
                          ),
                           Text(
                            S.of(context).virtualCardTransactions,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TransactionForm(),
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
                            child: Image.asset('images/icons/card_icon.png'),
                            height: 25.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 25.0,
                          ),
                           Text(
                            S.of(context).visaTransactions,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'VarelaRoundRegular',
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VisaTransactionsForm(),
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
