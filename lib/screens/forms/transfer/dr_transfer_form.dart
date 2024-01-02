import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/dr_benef.dart';
import 'package:gpay/models/dr_benef_list.dart';
import 'package:gpay/models/transfer/drtransfer_pay_response.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:gpay/services/transfer_services.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/widgets/transfer_disclosure_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrTransferForm extends StatefulWidget {
  const DrTransferForm({Key? key}) : super(key: key);

  @override
  _DrTransferFormState createState() => _DrTransferFormState();
}

class _DrTransferFormState extends State<DrTransferForm>
    with WidgetsBindingObserver {
  //Variables
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _amountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _recipientController = TextEditingController();
  bool isProcessing = false;
  bool beneficiariesLoaded = false;
  DrTransferPayResponse drTransferPayResponse = DrTransferPayResponse();
  DrBenef? drBenefSelected;
  DrBenefList? drBeneficiaries;


  //function to obtain DR BenefID for picker
  _getDrBenefID() async {
    await GeneralServices.getDrBenefID().then((list) => {
          setState(() {
            drBeneficiaries = DrBenefList.fromJson(list);
            beneficiariesLoaded = true;
          })
        });
  }

  //functions for dialogs
  _showSuccessResponse(
      BuildContext context, DrTransferPayResponse drTransferPayResponse) {
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
                              child: Text(drTransferPayResponse.transID.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                S.of(context).AmountDOP,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(drTransferPayResponse.transferAmount.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                S.of(context).debitedusd,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child:
                                  Text(drTransferPayResponse.debitedAmount.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                S.of(context).rate,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child:
                                  Text(drTransferPayResponse.rate.toString()),
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
      DrTransferPayResponse drTransferPayResponse = DrTransferPayResponse.fromJson(json);
      _showSuccessResponse(context, drTransferPayResponse);
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
      _passwordController.text = '';
      _recipientController.text = '';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await TransferServices.getDrBankTransfer(
            _passwordController.text,
            _amountController.text,
      drBenefSelected!.benefID.toString(),
            _recipientController.text)
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
    _getDrBenefID();
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
          S.of(context).toDrBankAccount,
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
                          beneficiariesLoaded
                              ? Container(
                                  child: DropdownButton<DrBenef>(
                                    hint: Text(
                                      S.of(context).selectDrBeneficiary,
                                      style: const TextStyle(
                                        color: Colors.black26,
                                        fontFamily: 'VarelaRoundRegular',
                                      ),
                                    ),
                                    value: drBenefSelected,
                                    onChanged: (DrBenef? value) {
                                      setState(() {
                                        drBenefSelected = value;
                                      });
                                    },
                                    items: drBeneficiaries!.DrBeneficiaries!
                                        .map((DrBenef drBenef) {
                                      return DropdownMenuItem<DrBenef>(
                                        value: drBenef,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          width: 250,
                                          child: Text(
                                            drBenef.benefName.toString(),
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
                                          S.of(context).noDrBeneficiary,
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
                                    S.of(context).drBeneficiary,
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
                              controller: _recipientController,
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
