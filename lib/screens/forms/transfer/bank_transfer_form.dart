import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/transfer/bank_account.dart';
import 'package:gpay/models/transfer/bank_accounts.dart';
import 'package:gpay/models/transfer/bank_transfer_response.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:gpay/services/transfer_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankTransferForm extends StatefulWidget {
  const BankTransferForm({Key? key}) : super(key: key);

  @override
  _BankTransferFormState createState() => _BankTransferFormState();
}

class _BankTransferFormState extends State<BankTransferForm> with WidgetsBindingObserver{

  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  BankAccount? selectedBankAccount;
  BankAccounts? bankAccounts;
  bool bankAccountsLoaded = false;
  bool isProcessing = false;

  //function to obtain bank account for picker
  _getBankAccounts() async {
    await TransferServices.getBankAccounts().then((list) => {
      setState(() {
        bankAccounts = BankAccounts.fromJson(list);
        bankAccountsLoaded = true;
      })
    });
  }

  //functions for dialogs
  _showSuccessResponse(BuildContext context, BankTransferResponse bankTransferResponse){

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.greenAccent,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                             SizedBox(
                              child: Text(
                                S.of(context).card,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(bankTransferResponse.cardNumber.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             SizedBox(
                              child: Text(
                               S.of(context).amountDebited,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(bankTransferResponse.debitedAmount.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             SizedBox(
                              child: Text(
                                S.of(context).authorization,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(bankTransferResponse.authNo.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 40),
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
          ),
        );
      },
    );

  }

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
  _checkResponse(BuildContext context, dynamic json) async{
    if(json['ErrorCode'] == 0){

      BankTransferResponse  bankTransferResponse = BankTransferResponse.fromJson(json);
      _showSuccessResponse(context, bankTransferResponse);

    } else{
      String errorMessage = await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }

  //Reset from
  _resetForm(){
    setState(() {
      isProcessing = false;
      _amountController.text = '';
      _notesController.text = '';
      _passwordController.text = '';
    });
  }
  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await TransferServices.getBankTransfer(_passwordController.text,_amountController.text, selectedBankAccount!.bankId.toString(),_notesController.text)
        .then((response) => {
      if(response['ErrorCode'] != null){
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
  void initState(){
    _getBankAccounts();
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
          S.of(context).toUSBank,
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
        builder: (context)=>Form(
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
                          bankAccountsLoaded
                          ? Container(
                            child: DropdownButton<BankAccount>(
                              hint:  Text(S.of(context).selectBankAccount,
                                style: const TextStyle(
                                  color: Colors.black26,
                                  fontFamily: 'VarelaRoundRegular',
                                ),
                              ),
                              value: selectedBankAccount,
                              onChanged: (BankAccount? value) {
                                setState(() {
                                  selectedBankAccount = value;
                                });
                              },
                              items: bankAccounts!.accounts!
                                  .map((BankAccount bankAccount) {
                                return DropdownMenuItem<BankAccount>(
                                  value: bankAccount,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    width: 250,
                                    child: Text(
                                      '${bankAccount.bankName.toString()} ${bankAccount.accountNo.toString()}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'VarelaRoundRegular',
                                        ),
                                    ),
                                  ),
                                );
                              }).toList(),
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
                          )
                          :Container(
                            child:  TextField(
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).noBankAccounts,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
                              keyboardType: TextInputType.phone,
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
                          Container(
                            child: TextFormField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    S.of(context).note,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return S.of(context).required;
                                }
                              },
                              controller: _notesController,
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
                          Container(
                            child: TextFormField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    S.of(context).password,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return S.of(context).required;
                                }
                              },
                              controller: _passwordController,
                              obscureText: true,
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
                           child:  Container(
                             child: TextButton(
                               child:  Text(
                                 S.of(context).send,
                                 style: const TextStyle(
                                     color: Color(0xFF194D82),
                                     fontFamily: 'VarelaRoundRegular',
                                     fontWeight: FontWeight.bold,
                                     fontSize: 20.0
                                 ),
                               ),
                               onPressed: (){
                                 if(_formKey.currentState!.validate()){
                                   _executeTransaction(context);
                                 }
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
                        child:  Text(
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
