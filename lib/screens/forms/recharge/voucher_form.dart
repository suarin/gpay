import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/login_success_response.dart';
import 'package:gpay/models/payment_type.dart';
import 'package:gpay/models/recharge/card_load_voucher_response.dart';
import 'package:gpay/services/recharge_services.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherForm extends StatefulWidget {
  const VoucherForm({Key? key}) : super(key: key);

  @override
  _VoucherFormState createState() => _VoucherFormState();
}

class _VoucherFormState extends State<VoucherForm> with WidgetsBindingObserver {
  //Variables
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _mobileController = TextEditingController();
  final _voucherController = TextEditingController();
  final _virtualCardController = TextEditingController();
  final _merchantController = TextEditingController();
  PaymentType? selectedPaymentType;
  List<PaymentType> paymentTypes = <PaymentType>[];
  CardLoadVoucherResponse cardLoadVoucherResponse = CardLoadVoucherResponse();
  bool isProcessing = false;
  bool visaCardsLoaded = false;
  bool showMobileField = false;
  var screenSize, screenWidth, screenHeight;
  //Get user data
  _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    LoginSuccessResponse loginSuccessResponse = LoginSuccessResponse(
        errorCode: 0,
        cHolderID: prefs.getInt('cHolderID'),
        userName: prefs.getString('userName'),
        cardNo: prefs.getString('cardNo'),
        currency: prefs.getString('currency'),
        balance: prefs.getString('balance'));
    setState(() {
      _virtualCardController.text = loginSuccessResponse.cardNo.toString();
    });
  }

  //functions for data pickers
  _loadPaymentTypes() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/payment_types.json');
    final jsonResult = jsonDecode(data);
    setState(() {
      for (int i = 0; i < jsonResult.length; i++) {
        PaymentType paymentType = PaymentType.fromJson(jsonResult[i]);
        paymentTypes.add(paymentType);
      }
    });
  }

  //functions for dialogs
  _showSuccessResponse(
      BuildContext context, CardLoadVoucherResponse cardLoadVoucherResponse) {
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
                                S.of(context).amount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(cardLoadVoucherResponse.amountLoad
                                  .toString()),
                              width: 150,
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 40),
                  ),
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
                              child: Text(
                                  cardLoadVoucherResponse.authNo.toString()),
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
      CardLoadVoucherResponse cardLoadVoucherResponse =
          CardLoadVoucherResponse.fromJson(json);
      _showSuccessResponse(context, cardLoadVoucherResponse);
    } else {
      String errorMessage =
          await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }

  //Reset form
  _resetForm() {
    setState(() {
      isProcessing = false;
      _voucherController.text = '';
      _mobileController.text = '';
      _merchantController.text = '';
      _virtualCardController.text = '';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await RechargeServices.getCardLoadVoucher(
            _merchantController.text,
            selectedPaymentType!.typeId.toString(),
            _voucherController.text,
            _virtualCardController.text,
            _mobileController.text)
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
    _loadPaymentTypes();
    _getUserData();
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
          height: 150.0,
        ),
        title: Text(
          S.of(context).voucherLoad,
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
                  Positioned(
                    child: SizedBox(
                      child: ListView(
                        children: [
                          Container(
                            child: DropdownButton<PaymentType>(
                              hint: Text(S.of(context).select,
                                  style: const TextStyle(
                                    color: Colors.black26,
                                    fontFamily: 'VarelaRoundRegular',
                                  )),
                              value: selectedPaymentType,
                              onChanged: (PaymentType? value) {
                                setState(() {
                                  selectedPaymentType = value;
                                  if (value!.typeId == 'P') {
                                    showMobileField = true;
                                    _mobileController.text = '';
                                  } else {
                                    showMobileField = false;
                                    _mobileController.text = '0';
                                  }
                                });
                              },
                              items: paymentTypes.map((PaymentType payment) {
                                return DropdownMenuItem<PaymentType>(
                                  value: payment,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    width: 250,
                                    child: Text(
                                      payment.type.toString(),
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
                                Radius.circular(30.0),
                              ),
                            ),
                            margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            width: 200,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).merchantPassword,
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
                              controller: _merchantController,
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
                                    S.of(context).gpsAccount,
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
                              controller: _virtualCardController,
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
                                    S.of(context).voucherNumber,
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
                              controller: _voucherController,
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                      S.of(context).phone,
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
                                controller: _mobileController,
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
                            visible: showMobileField,
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
        ),
      ),
    );
  }
}
