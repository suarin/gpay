import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/issue/account_transaction_form.dart';
import 'package:gpay/screens/forms/issue/add_account_form.dart';
import 'package:gpay/screens/forms/issue/balance_form.dart';
import 'package:gpay/screens/forms/issue/bills_screen.dart';
import 'package:gpay/screens/forms/issue/visa_balance_form.dart';
import 'package:gpay/screens/forms/issue/visa_request_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({Key? key}) : super(key: key);

  @override
  _IssueScreenState createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> with WidgetsBindingObserver{

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
          S.of(context).requisition,
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
                            child: Image.asset('images/icons/card_icon.png'),
                            height: 25.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 25.0,
                          ),
                           Text(
                            S.of(context).virtualCardBalance,
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
                            builder: (context) => const BalanceForm(),
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
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            S.of(context).visaBalance,
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
                            builder: (context) => const VisaBalanceForm(),
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
                            child: Image.asset('images/icons/issue_card_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            S.of(context).visaRequest,
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
                            builder: (context)=>const VisaRequestForm()
                          )
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
                            child: Image.asset('images/icons/balance_icon.png'),
                            height: 35.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 35.0,
                          ),
                           Text(
                            S.of(context).viewTransactions,
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
                            builder: (context) => const AccountTransactionForm(),
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
                            child: Image.asset('images/icons/service_payment_icon.png'),
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 50.0,
                          ),
                           Text(
                            S.of(context).servicePay,
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
                            builder: (context) => const BillsScreen(),
                          )
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
                            child: Image.asset('images/icons/card_icon.png'),
                            height: 50.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            width: 50.0,
                          ),
                          Text(
                            S.of(context).addAccount,
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
                              builder: (context) => const AddAccountForm(),
                            )
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
              top: screenHeight - 140.0,
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
