import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/country.dart';
import 'package:gpay/models/document_type.dart';
import 'package:gpay/models/general/registration_success_response.dart';
import 'package:gpay/screens/identity_check_screen.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/services/system_errors.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _identificationNumberController = TextEditingController();
  final _recomendationNumberController = TextEditingController();
  List<Country> countries = <Country>[];
  List<DocumentType> documentTypes = <DocumentType>[];
  Country? selectedCountry ;
  DocumentType? selectedDocumentType;
  bool isProcessing = false;
  RegistrationSuccessResponse registrationSuccessResponse = RegistrationSuccessResponse();

  //Functions for data pickers
  _loadCountries() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/countries.json");
    final jsonResult = jsonDecode(data);
    setState(() {
      for (int i = 0; i < jsonResult.length; i++) {
        Country country = Country.fromJson(jsonResult[i]);
        countries.add(country);
      }
    });
  }

  _loadDocumentTypes() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/document_types.json");
    final jsonResult = jsonDecode(data);
    setState(() {
      for (int i = 0; i < jsonResult.length; i++) {
        DocumentType documentType = DocumentType.fromJson(jsonResult[i]);
        documentTypes.add(documentType);
      }
    });
  }

  //functions for dialogs
  _showSuccessResponse(BuildContext context, RegistrationSuccessResponse registrationSuccessResponse){

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
                                S.of(context).cardHolderId,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(registrationSuccessResponse.cHolderId.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             SizedBox(
                              child: Text(
                                S.of(context).cardNumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(registrationSuccessResponse.cardNo.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             SizedBox(
                              child: Text(
                                S.of(context).userId,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(registrationSuccessResponse.userId.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             SizedBox(
                              child: Text(
                                S.of(context).password,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(registrationSuccessResponse.password.toString()),
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
                              child: Text(registrationSuccessResponse.authno.toString()),
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

      RegistrationSuccessResponse  registrationSuccessResponse = RegistrationSuccessResponse.fromJson(json);
      _showSuccessResponse(context, registrationSuccessResponse);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  IdentityCheckScreen(registrationSuccessResponse: registrationSuccessResponse))
      );
    } else{
      String errorMessage = await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }

  //reset form
  _resetForm(){
    setState(() {
      isProcessing = false;
      _emailController.text = '';
      _identificationNumberController.text = '';
      _mobileNumberController.text ='';
      _lastNameController.text = '';
      _firstNameController.text ='';
      _recomendationNumberController.text='';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await GeneralServices.getCustomerRegistration(_recomendationNumberController.text,_firstNameController.text,_lastNameController.text,_mobileNumberController.text,_emailController.text,selectedCountry!.alpha3.toString(),selectedDocumentType!.ID.toString(),_identificationNumberController.text)
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

  @override
  void initState(){
    _loadCountries();
    _loadDocumentTypes();
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
        title: Text(
          S.of(context).signUp,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                            decoration:  InputDecoration(
                                label: Text(
                                  S.of(context).promotionalCode,
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
                            controller: _recomendationNumberController,
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
                                  S.of(context).names,
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
                            controller: _firstNameController,
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
                                  S.of(context).surnames,
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
                            controller: _lastNameController,
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
                                  S.of(context).phone,
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
                            controller: _mobileNumberController,
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
                                  S.of(context).email,
                                  style: const TextStyle(
                                    color: Colors.black26,
                                    fontFamily: 'VarelaRoundRegular',
                                  ),
                                ),
                                border: InputBorder.none
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return S.of(context).required;
                              }
                            },
                            controller: _emailController,
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
                          child: DropdownButton<Country>(
                            hint:  Text(S.of(context).selectCountry),
                            value: selectedCountry,
                            onChanged: (Country? value){
                              setState(() {
                                selectedCountry = value;
                              });
                            },
                            items: countries.map((Country country) {
                              return DropdownMenuItem<Country>(
                                value: country,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  width: 250,
                                  child: Text(
                                    country.name,
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
                              borderRadius: BorderRadius.all(Radius.circular(25.0))
                          ),
                          padding: const EdgeInsets.only(left: 10.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          width: 250.0,
                        ),
                        Container(
                          child: DropdownButton<DocumentType>(
                            hint:  Text(S.of(context).documentType),
                            value: selectedDocumentType,
                            onChanged: (DocumentType? value){
                              setState(() {
                                selectedDocumentType = value;
                              });
                            },
                            items: documentTypes.map((DocumentType documentType) {
                              return DropdownMenuItem<DocumentType>(
                                value: documentType,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  width: 250,
                                  child: Text(
                                    '${documentType.ID} ${documentType.description}' ,
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
                              borderRadius: BorderRadius.all(Radius.circular(25.0))
                          ),
                          padding: const EdgeInsets.only(left: 10.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          width: 250.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration:  InputDecoration(
                                label: Text(
                                  S.of(context).identificationNumber,
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
                            controller: _identificationNumberController,
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
                                S.of(context).signUp,
                                style: const TextStyle(
                                    color: Color(0xFF194D82),
                                    fontFamily: 'VarelaRoundRegular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),
                              ),
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
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
                    height: screenHeight - 100,
                    margin: EdgeInsets.only(left: (screenWidth-300)/2,top: 10.0),
                    width: 300,
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
        ),
      ),
      key: scaffoldState,
      resizeToAvoidBottomInset: true,

    );
  }
}
