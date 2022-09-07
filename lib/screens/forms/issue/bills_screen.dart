import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/bill.dart';
import 'package:gpay/models/general/bills_reponse.dart';
import 'package:gpay/screens/forms/issue/pay_bill_form.dart';
import 'package:gpay/services/general_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({Key? key}) : super(key: key);

  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> with WidgetsBindingObserver{
  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  bool billsLoaded = false;
  bool isProcessing = false;
  Bill? bill;
  BillsResponse? billsResponse;
  //Function to obtain bills
  _getBills() async{
    await GeneralServices.getBills().then((list) => {
      billsResponse = BillsResponse.fromJson(list),
      setState(() {
        billsLoaded = true;
      })
    });
  }

  _offScanning() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning',false);
  }

  @override
  void initState(){
    _offScanning();
    _getBills();
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
          S.of(context).bills,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: billsLoaded? Builder(
        builder: (context)=>SizedBox(
          child:SafeArea(
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
                    child:  ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: billsResponse!.bills!.length,
                        itemBuilder: (context , index){
                          Bill bill = billsResponse!.bills![index];
                          return Container(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    bill.billerName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  Text(
                                    '${S.of(context).bills}: ${bill.invoiceNo.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                      letterSpacing: 2.5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'ID: ${bill.billerId.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            fontFamily: 'VarelaRoundRegular',
                                          ),
                                        ),
                                        width: 50,
                                      ),
                                      SizedBox(
                                        child: ElevatedButton(
                                          child:  Text(S.of(context).pay),
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0XFF0E325F),
                                          ),
                                          onPressed: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => PayBillForm(bill: bill)
                                                )
                                            );
                                          },
                                        ),
                                        width: 125,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'USD ${bill.amount}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            fontFamily: 'VarelaRoundRegular',
                                          ),
                                        ),
                                        width: 75,
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              ),
                            ),
                            decoration:   const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.only(left: 20),
                            width: 200,
                            height: 125,
                          );
                        }
                    ),
                    height: screenHeight - 100,
                    width: screenWidth,
                  ),
                  top: 10,
                  left: (screenWidth - 350)  / 2,
                ),
              ],
            ),
          ),
          width: screenWidth,
          height: screenHeight,
        ),
      ):  Text(S.of(context).noBills),
    );
  }
}
