import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/login_success_response.dart';
import 'package:gpay/screens/forms/registration_form.dart';
import 'package:gpay/screens/principal_screen.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  String userID = '';
  bool isProcessing = false;

  //functions for dialogs
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
      LoginSuccessResponse loginSuccessResponse =
          LoginSuccessResponse.fromJson(json);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt('cHolderID', loginSuccessResponse.cHolderID!);
      await prefs.setString('userID', userID);
      await prefs.setString('userName', loginSuccessResponse.userName!);
      await prefs.setString('cardNo', loginSuccessResponse.cardNo!);
      await prefs.setString('currency', loginSuccessResponse.currency!);
      await prefs.setString('balance', loginSuccessResponse.balance!);
      await prefs.setBool('isScanning', false);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PrincipalScreen()));
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
      _userController.text = '';
      _passwordController.text = '';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
      userID = _userController.text;
    });
    await GeneralServices.getLogin(
            _userController.text, _passwordController.text)
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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      child: Scaffold(
        key: scaffoldStateKey,
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SizedBox(
              child: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      child: SizedBox(
                        child: Image.asset(
                          'images/backgrounds/page_header.png',
                          fit: BoxFit.fill,
                        ),
                        height: screenHeight / 3,
                        width: screenWidth,
                      ),
                    ),
                    Positioned(
                      child: SizedBox(
                        child: Text(
                          S.of(context).welcome,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.w900,
                            fontSize: 30.0,
                          ),
                        ),
                        width: 260,
                      ),
                      top: screenHeight / 8,
                      left: (screenWidth - 275) / 2,
                    ),
                    Positioned(
                      child: SizedBox(
                        child: ListView(
                          children: [
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                      S.of(context).user,
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
                                controller: _userController,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0XFF01ACCA)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              margin: const EdgeInsets.only(bottom: 15.0),
                              padding: const EdgeInsets.only(left: 10.0),
                              width: 300,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                      S.of(context).password,
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
                                border:
                                    Border.all(color: const Color(0XFF01ACCA)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              margin: const EdgeInsets.only(bottom: 15.0),
                              padding: const EdgeInsets.only(left: 10.0),
                              width: 300,
                            ),
                            Visibility(
                              child: Container(
                                child: TextButton(
                                  child: Text(
                                    S.of(context).signIn,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'VarelaRoundRegular',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  onPressed: () {
                                    _executeTransaction(context);
                                  },
                                ),
                                decoration: const BoxDecoration(
                                    color: Color(0xFF00CAB2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                height: 60.0,
                                margin: const EdgeInsets.only(bottom: 5.0),
                              ),
                              visible: !isProcessing,
                            ),
                            Container(
                              child: TextButton(
                                child: Text(
                                  S.of(context).signUp,
                                  style: const TextStyle(
                                      color: Color(0XFF01ACCA),
                                      fontFamily: 'VarelaRoundRegular',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationForm()));
                                },
                              ),
                              margin: const EdgeInsets.only(bottom: 5.0),
                              height: 35.0,
                            ),
                          ],
                        ),
                        height: 300.0,
                        width: 300.0,
                      ),
                      top: screenHeight / 3,
                      left: (screenWidth - 300) / 2,
                    ),
                    Positioned(
                      child: SizedBox(
                        child: Image.asset(
                            'images/logos/gpay_blue_logo_87x40.png'),
                        width: 87,
                      ),
                      top: screenHeight - 130,
                      left: (screenWidth - 87) / 2,
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
                      top: screenHeight - 75.0,
                    ),
                  ],
                ),
              ),
              height: screenHeight,
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
      ),
      onWillPop: () async => true,
    );
  }
}
