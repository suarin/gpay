import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpay/models/general/bill.dart';
import 'package:gpay/models/general/bill_payment_response.dart';
import 'package:gpay/models/general/visa_card.dart';
import 'package:gpay/models/general/visa_cards_response.dart';
import 'package:gpay/models/rush_payment.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/services/system_errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayBillForm extends StatefulWidget {
  final Bill? bill;
  const PayBillForm({Key? key, @required this.bill}) : super(key: key);

  @override
  _PayBillFormState createState(){
    return  _PayBillFormState(bill: this.bill);
  }
}

class _PayBillFormState extends State<PayBillForm> with WidgetsBindingObserver{
//Constructor
  _PayBillFormState({Key? key, @required this.bill});
  final Bill? bill;
  //Variables
  var screenSize, screenWidth, screenHeight;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  VisaCardsResponse? visaCardsResponse;
  BillPaymentResponse? _billPaymentResponse;
  bool visaCardsLoaded = false;
  bool rushPaymentsLoaded = false;
  bool isProcessing = false;
  VisaCard? selectedVisaCard;
  RushPayment? _selectedRushPayment;
  final List<RushPayment> _rushPayments = <RushPayment>[];

  //functions for data pickers
  _loadRushPayment()async{
    String data = await DefaultAssetBundle.of(context).loadString('assets/rush_payment.json');
    final jsonResult = jsonDecode(data);
    setState(() {
      for(int i = 0; i < jsonResult.length; i++){
        RushPayment rushPayment = RushPayment.fromJson(jsonResult[i]);
        _rushPayments.add(rushPayment);
        rushPaymentsLoaded = true;
      }
    });
  }

  //function to obtain Visa Cards for picker
  _getVisaCards() async {
    await GeneralServices.getVirtualCards().then((list) => {
      setState(() {
        visaCardsResponse = VisaCardsResponse.fromJson(list);
        visaCardsLoaded = true;
      })
    });
  }

  //functions for dialogs
  _showSuccessResponse(BuildContext context, BillPaymentResponse billPaymentResponse){
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
                            const SizedBox(
                              child: Text(
                                'Autorizacion',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(billPaymentResponse.authNo.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              child: Text(
                                'Proveedor',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(billPaymentResponse.billerName.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              child: Text(
                                'Costo del Producto',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(billPaymentResponse.productCost.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              child: Text(
                                'Pagado',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(billPaymentResponse.totalPaid.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              child: Text(
                                'Comision',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(billPaymentResponse.fee.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              child: Text(
                                'No Cuenta',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              width: 150,
                            ),
                            SizedBox(
                              child: Text(billPaymentResponse.accountNo.toString()),
                              width: 150,
                            ),
                          ],
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(left: 40),
                  ),
                  ElevatedButton(
                    child: const Text('Cerrar'),
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
                  child: const Text('Cerrar'),
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

      BillPaymentResponse  billPaymentResponse = BillPaymentResponse.fromJson(json);
      _showSuccessResponse(context, billPaymentResponse);

    } else{
      String errorMessage = await SystemErrors.getSystemError(json['ErrorCode']);
      _showErrorResponse(context, errorMessage);
    }
  }

  //Reset form
  _resetForm(){
    setState(() {
      isProcessing = false;
      _passwordController.text ='';
    });
  }

  //Execute registration
  _executeTransaction(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });
    await GeneralServices.getPayBill(
        bill!.invoiceNo.toString(),
        selectedVisaCard!.cardNo.toString(),
        _passwordController.text,
        bill!.amount.toString(),
        bill!.billerId.toString(),
        bill!.acoountNo.toString(),
        _selectedRushPayment!.optionId.toString()
    ).then((response) => {
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
    _loadRushPayment();
    _getVisaCards();
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
        title: const Text(
          'Balance Tarjeta Virtual',
          style: TextStyle(
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
                            child: TextField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    'Factura: ${bill!.invoiceNo.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
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
                            child: TextField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    'Monto: ${bill!.amount.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
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
                            child: TextField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    'ID Proveedor: ${bill!.billerId.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
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
                            child: TextField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    'No Cuenta: ${bill!.acoountNo.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
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
                          rushPaymentsLoaded
                          ?Container(
                            child: DropdownButton<RushPayment>(
                              hint: const Text('Seleccione Si o No para Agilizar',
                                style:  TextStyle(
                                  color: Colors.black26,
                                  fontFamily: 'VarelaRoundRegular',
                                ),
                              ),
                              value: _selectedRushPayment,
                              onChanged: (RushPayment? value) {
                                setState(() {
                                  _selectedRushPayment = value;
                                });
                              },
                              items: _rushPayments
                                  .map((RushPayment rushPayment) {
                                return DropdownMenuItem<RushPayment>(
                                  value: rushPayment,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    width: 250,
                                    child: Text(
                                      rushPayment.optionName.toString(),
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
                            child: const TextField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    'Cargando...',
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
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
                          visaCardsLoaded
                          ? Container(
                            child: DropdownButton<VisaCard>(
                              hint: const Text('Seleccionar Tarjeta',
                                style:  TextStyle(
                                  color: Colors.black26,
                                  fontFamily: 'VarelaRoundRegular',
                                ),
                              ),
                              value: selectedVisaCard,
                              onChanged: (VisaCard? value) {
                                setState(() {
                                  selectedVisaCard = value;
                                });
                              },
                              items: visaCardsResponse!.visaCards!
                                  .map((VisaCard visaCard) {
                                return DropdownMenuItem<VisaCard>(
                                  value: visaCard,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    width: 250,
                                    child: Text(
                                      visaCard.cardNo.toString(),
                                      style:  const TextStyle(
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
                            child: TextField(
                              decoration:  InputDecoration(
                                  label: Text(
                                    'No Cuenta: ${bill!.acoountNo.toString()}',
                                    style: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
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
                              decoration: const InputDecoration(
                                  label: Text(
                                    'Contraseña *',
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  border: InputBorder.none
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Campo obligatorio';
                                }
                              },
                              controller: _passwordController,
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
                          Visibility(
                            child: Container(
                              child: TextButton(
                                child: const Text(
                                  'Solicitar',
                                  style: TextStyle(
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
                        child: const Text(
                          'Procesando...',
                          style: TextStyle(
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
