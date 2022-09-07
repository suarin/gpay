import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/authorization_response.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisaRequestForm  extends StatefulWidget {
  const VisaRequestForm({Key? key}) : super(key: key);

  @override
  _VisaRequestForm createState() => _VisaRequestForm();
}

class _VisaRequestForm extends State<VisaRequestForm> with WidgetsBindingObserver{
  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isProcessing = false;
  AuthorizationResponse authorizationResponse = AuthorizationResponse();

  //functions for dialogs
  _showSuccessResponse(BuildContext context, AuthorizationResponse authorizationResponse){

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
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(authorizationResponse.authNo.toString()),
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

      AuthorizationResponse  authorizationResponse = AuthorizationResponse.fromJson(json);
      _showSuccessResponse(context, authorizationResponse);

    } else{
      String errorMessage = await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }

  //Reset form
  _resetForm(){
    setState(() {
      isProcessing = false;
      _phoneController.text = '';
      _zipController.text = '';
      _provinceController.text = '';
      _cityController.text = '';
      _addressController.text = '';
      _passwordController.text = '';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await GeneralServices.getVisaRequest(_passwordController.text,_addressController.text,_cityController.text,_provinceController.text,_zipController.text, _phoneController.text)
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
          S.of(context).visaRequest,
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
                          Container(
                            child: TextFormField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    S.of(context).address,
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
                              controller: _addressController,
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
                                    S.of(context).city,
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
                              controller: _cityController,
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
                                    S.of(context).province,
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
                              controller: _provinceController,
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
                                    S.of(context).postalCode,
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
                              controller: _zipController,
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
                              decoration: InputDecoration(
                                  label: Text(
                                    S.of(context).phone,
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
                              controller: _phoneController,
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
                                    S.of(context).password,
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
                              obscureText: true,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return S.of(context).required;
                                }
                              },
                              controller: _passwordController,
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
