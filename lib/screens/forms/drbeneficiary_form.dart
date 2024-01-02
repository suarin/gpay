import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/transfer/dr_bank.dart';
import 'package:gpay/models/transfer/dr_bank_list.dart';
import 'package:gpay/models/general/drbeneficiary_success_response.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/services/transfer_services.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrBeneficiaryForm extends StatefulWidget {
  const DrBeneficiaryForm({Key? key}) : super(key: key);

  @override
  _DrBeneficiaryFormState createState() => _DrBeneficiaryFormState();
}

class _DrBeneficiaryFormState extends State<DrBeneficiaryForm> {
  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _firstNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _identificationNumberController = TextEditingController();
  bool isProcessing = false;
  bool banksLoaded = false;
  DrbenefSuccessResponse drbenefSuccessResponse = DrbenefSuccessResponse();
  DrBank? drBankSelected;
  DrBankList? drBanks;


  //function to obtain dr bank for picker
  _getDrBanks() async {
    await TransferServices.getDrBanks().then((list) => {
      setState(() {
        drBanks = DrBankList.fromJson(list);
        banksLoaded = true;
      })
    });
  }

  //functions for dialogs
  _showSuccessResponse(
      BuildContext context, DrbenefSuccessResponse drbenefSuccessResponse) {
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
                                S.of(context).benefId,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(drbenefSuccessResponse.benefId.toString()),
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
      DrbenefSuccessResponse drbenefSuccessResponse = DrbenefSuccessResponse.fromJson(json);
      _showSuccessResponse(context, drbenefSuccessResponse);
    } else {
      String errorMessage =
      await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }


  //reset form
  _resetForm() {
    setState(() {
      isProcessing = false;
      _firstNameController.text = '';
      _identificationNumberController.text = '';
      _emailController.text = '';
      _mobileNumberController.text = '';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    if (drBankSelected != null) {
      // Existing code when drBankSelected is not null
      await GeneralServices.getDrBeneficiary(
          _firstNameController.text,
          _identificationNumberController.text,
          _emailController.text,
          drBankSelected!.bankID.toString(),
          _mobileNumberController.text)
          .then((response) {
        if (response['ErrorCode'] != null) {
          _checkResponse(context, response);
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
    } else {
      // Handle the case where drBankSelected is null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a bank', // Your message here
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      _resetForm();
    }
  }

  _offScanning() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning', false);
  }

  @override
  void initState() {
    _getDrBanks();
    _offScanning();
    super.initState();
  }

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
          S.of(context).drBeneficiary,
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
          key: _formKey,
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
                  Container(
                    child: ListView(
                      children: [
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                                label: Text(
                                  S.of(context).names,
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
                            controller: _firstNameController,
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
                                  S.of(context).identificationNumber,
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
                            controller: _identificationNumberController,
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
                                  S.of(context).email,
                                  style: const TextStyle(
                                    color: Colors.black26,
                                    fontFamily: 'VarelaRoundRegular',
                                  ),
                                ),
                                border: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).required;
                              }
                            },
                            controller: _emailController,
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
                          child: DropdownButton<DrBank>(
                            hint: Text(S.of(context).selectDrBank),
                            value: drBankSelected,
                            onChanged: (DrBank? value) {
                              setState(() {
                                drBankSelected = value;
                              });
                            },
                            items: drBanks!.DrBanks!.map((DrBank drBank) {
                              return DropdownMenuItem<DrBank>(
                                value: drBank,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  width: 250,
                                  child: Text(
                                    drBank.bankName.toString(),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "NanumGothic Bold",
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFF00FFD5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          padding: const EdgeInsets.only(left: 10.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          width: 250.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                                label: Text(
                                  S.of(context).drBankAccount,
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
                            controller: _mobileNumberController,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
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
                                    color: Color(0xFF194D82),
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
                                color: Color(0xFF00FFD5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                            width: 300.0,
                          ),
                          visible: !isProcessing,
                        ),
                      ],
                    ),
                    height: screenHeight - 100,
                    margin: EdgeInsets.only(
                        left: (screenWidth - 300) / 2, top: 10.0),
                    width: 300,
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
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
