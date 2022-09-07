import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: orfan form

class BankDepositForm extends StatefulWidget {
  const BankDepositForm({Key? key}) : super(key: key);

  @override
  _BankDepositFormState createState() => _BankDepositFormState();
}

class _BankDepositFormState extends State<BankDepositForm> with WidgetsBindingObserver{

  var screenSize, screenWidth, screenHeight;

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
        title: const Text(
          'Depósito Bancario',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
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
                        //TODO: replace with picker of banks
                        child: const TextField(
                          decoration: InputDecoration(
                              label: Text(
                                'Selecciona Banco',
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
                      Container(
                        //TODO: replace with picker of banks
                        child: const TextField(
                          decoration: InputDecoration(
                              label: Text(
                                'Monto',
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontFamily: 'VarelaRoundRegular',
                                ),
                              ),
                              border: InputBorder.none,
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
                        //TODO: replace with picker of banks
                        child: const TextField(
                          decoration: InputDecoration(
                            label: Text(
                              'PIN Web',
                              style: TextStyle(
                                color: Colors.black26,
                                fontFamily: 'VarelaRoundRegular',
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          obscureText: true,
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
                        child: TextButton(
                          child: const Text(
                            'Realizar Depósito',
                            style: TextStyle(
                                color: Color(0xFF194D82),
                                fontFamily: 'VarelaRoundRegular',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                            ),
                          ),
                          onPressed: (){},
                        ),
                        decoration: const BoxDecoration(
                            color: Color(0xFF00FFD5),
                            borderRadius: BorderRadius.all(Radius.circular(25.0))
                        ),
                        width: 300.0,
                      ),
                    ],
                  ),
                  height: screenHeight,
                  width: 300,
                ),
                top: 50,
                left: (screenWidth - 300) / 2,
              ),
            ],
          ),
        ),
        height: screenHeight,
        width: screenWidth,
      ),
    );

  }
}
