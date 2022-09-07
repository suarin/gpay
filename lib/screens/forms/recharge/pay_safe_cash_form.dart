import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/forms/recharge/pay_safe_cash_web_view.dart';
import 'package:gpay/services/recharge_services.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PaySafeCashForm extends StatefulWidget {
  const PaySafeCashForm({Key? key}) : super(key: key);

  @override
  _PaySafeCashFormState createState() => _PaySafeCashFormState();
}

class _PaySafeCashFormState extends State<PaySafeCashForm> with WidgetsBindingObserver {

  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _amountController = TextEditingController();
  bool isProcessing = false;
  String paySafeUrl= '';
  //functions for dialogs
  _showErrorResponse(BuildContext context, String errorMessage){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(errorMessage, style: const TextStyle(color: Colors.white),),
                  margin: const EdgeInsets.only(left: 40.0),
                ),
                ElevatedButton(
                  child:  Text(S.of(context).close),
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF0E325F),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //Check response
  _checkResponse(BuildContext context, String json) async{
    if(json.contains('https://customer.cc.at.paysafecard.com/rest/payment/panel?')){

      const start = "https://customer.cc.at.paysafecard.com/rest/payment/panel?";

      final startIndex = json.indexOf(start);
      paySafeUrl = json.substring(startIndex, json.length);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaySafeCashWebView(paySafeUrl: paySafeUrl)
        ),
      );
    } else{
      String errorMessage = await SystemErrors.getSystemError(0);
      _showErrorResponse(context, errorMessage);
    }
  }

  //Reset form
  _resetForm(){
    setState(() {
      isProcessing = false;
      _amountController.text ='';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await RechargeServices.getLoadPaySafe(_amountController.text)
        .then((response) => {
      if(response.contains('https://customer.cc.at.paysafecard.com/rest/payment/panel?')){
        _checkResponse(context, response),
      }
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      _resetForm();
    });
    _resetForm();
  }

  _offScanning() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning',false);
  }

  @override
  void initState() {
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
          '${S.of(context).loads} PaySafe:Cash',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: scaffoldStateKey,
      body: Builder(
        builder: (context) => Form(
          child: SizedBox(
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
                            child: TextFormField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    S.of(context).amount,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return S.of(context).required;
                                }
                              },
                              controller: _amountController,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(30.0))
                            ),
                            margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            width: 300,
                          ),
                          Visibility(
                            child: Container(
                              child: TextButton(
                                child: Text(
                                  S.of(context).send,
                                  style: const TextStyle(
                                      color: Color(0xFF194D82),
                                      fontFamily: 'VarelaRoundRegular',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                  ),
                                ),
                                onPressed: (){
                                  _executeTransaction(context);
                                },
                              ),
                              decoration: const BoxDecoration(
                                  color: Color(0xFF00FFD5),
                                  borderRadius: BorderRadius.all(Radius.circular(25.0))
                              ),
                              width: 300.0,
                            ),
                            visible: !isProcessing,
                          ),
                        ],
                      ),
                      height: screenHeight,
                      width: 300,
                    ),
                    top: 50,
                    left: (screenWidth - 300) / 2,
                  ),
                  Positioned(
                    child: Visibility(
                      child: Container(
                        child: Text(
                          S.of(context).processing,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                          ),
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.grey
                        ),
                        height: 50.0,
                        width: screenWidth,
                        padding: const EdgeInsets.all(10.0),
                      ),
                      visible: isProcessing,
                    ),
                    top: screenHeight - 130.0,
                  ),
                ],
              ),
            ),
            height: screenHeight,
            width: screenWidth,
          ),
          key: _formKey,
        ),
      ),
    );
  }
}
