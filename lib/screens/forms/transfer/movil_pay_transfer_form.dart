import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/transfer/movil_pay_bank.dart';
import 'package:gpay/models/transfer/movil_pay_bank_list.dart';
import 'package:gpay/models/transfer/movil_pay_response.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:gpay/services/transfer_services.dart';
import 'package:gpay/widgets/transfer_disclosure_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovilPayTransferForm extends StatefulWidget {
  const MovilPayTransferForm({Key? key}) : super(key: key);

  @override
  _MovilPayTransferFormState createState() => _MovilPayTransferFormState();
}

class _MovilPayTransferFormState extends State<MovilPayTransferForm>
    with WidgetsBindingObserver {
  //Variables
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _amountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _recipientController = TextEditingController();
  final _messageController = TextEditingController();
  final _cellphoneController = TextEditingController();
  bool isProcessing = false;
  bool banksLoaded = false;
  MovilPayResponse movilPayResponse = MovilPayResponse();
  MovilPayBank? movilPayBankSelected;
  MovilPayBankList? movilPayBanks;

  _getMovilPayBanks() async {
    await TransferServices.getMovilPayBanks().then((list) => {
          setState(() {
            movilPayBanks = MovilPayBankList.fromJson(list);
            banksLoaded = true;
          })
        });
  }

  //functions for dialogs
  _showSuccessResponse(
      BuildContext context, MovilPayResponse movilPayResponse) {
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
                                S.of(context).authorization,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(movilPayResponse.authNo.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                S.of(context).result,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(movilPayResponse.response.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                S.of(context).debited,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child:
                                  Text(movilPayResponse.totalDebit.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                S.of(context).bank,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child:
                                  Text(movilPayResponse.bankCodeID.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 40),
                  ),
                  ElevatedButton(
                    child: Text(S.of(context).close),
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

  _showErrorResponse(BuildContext context, String errorMessage) {
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
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                  margin: const EdgeInsets.only(left: 40.0),
                ),
                ElevatedButton(
                  child: Text(S.of(context).close),
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
  _checkResponse(BuildContext context, dynamic json) async {
    if (json['ErrorCode'] == 0) {
      MovilPayResponse movilPayResponse = MovilPayResponse.fromJson(json);
      _showSuccessResponse(context, movilPayResponse);
    } else {
      String errorMessage =
          await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }

  //Reset from
  _resetForm() {
    setState(() {
      isProcessing = false;
      _amountController.text = '';
      _messageController.text = '';
      _passwordController.text = '';
      _recipientController.text = '';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await TransferServices.getMovilPay(
            _passwordController.text,
            _amountController.text,
            _recipientController.text,
            movilPayBankSelected!.bankID.toString(),
            _messageController.text)
        .then((response) => {
              if (response['ErrorCode'] != null)
                {
                  _checkResponse(context, response),
                }
            })
        .catchError((error) {
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

  _offScanning() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning', false);
  }

  @override
  void initState() {
    _getMovilPayBanks();
    _offScanning();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
          S.of(context).toMobile,
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
                          TransferDisclosureWidget(
                              text: S.of(context).toMobileDisclosure),
                          banksLoaded
                              ? Container(
                                  child: DropdownButton<MovilPayBank>(
                                    hint: Text(
                                      S.of(context).selectBankAccount,
                                      style: const TextStyle(
                                        color: Colors.black26,
                                        fontFamily: 'VarelaRoundRegular',
                                      ),
                                    ),
                                    value: movilPayBankSelected,
                                    onChanged: (MovilPayBank? value) {
                                      setState(() {
                                        movilPayBankSelected = value;
                                      });
                                    },
                                    items: movilPayBanks!.movilPayBanks!
                                        .map((MovilPayBank movilPayBank) {
                                      return DropdownMenuItem<MovilPayBank>(
                                        value: movilPayBank,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          width: 250,
                                          child: Text(
                                            movilPayBank.bankName.toString(),
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
                                        color: const Color(0XFF01ACCA),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30.0))),
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  padding: const EdgeInsets.only(left: 10.0),
                                  width: 300,
                                )
                              : Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        label: Text(
                                          S.of(context).noBankAccounts,
                                          style: const TextStyle(
                                            color: Colors.black26,
                                            fontFamily: 'VarelaRoundRegular',
                                          ),
                                        ),
                                        border: InputBorder.none),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30.0))),
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  padding: const EdgeInsets.only(left: 10.0),
                                  width: 300,
                                ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).amount,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).required;
                                }
                              },
                              controller: _amountController,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFF01ACCA),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            width: 300,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).cellphone,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).required;
                                }
                              },
                              controller: _cellphoneController,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFF01ACCA),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            width: 300,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).note,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).required;
                                }
                              },
                              controller: _messageController,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFF01ACCA),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            width: 300,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).webPin,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).required;
                                }
                              },
                              controller: _passwordController,
                              obscureText: true,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFF01ACCA),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
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
                                      color: Colors.white,
                                      fontFamily: 'VarelaRoundRegular',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _executeTransaction(context);
                                  }
                                },
                              ),
                              decoration: const BoxDecoration(
                                  color: Color(0xFF00CAB2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
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
                        decoration: const BoxDecoration(color: Colors.grey),
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
