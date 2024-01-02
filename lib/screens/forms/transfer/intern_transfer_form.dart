import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/screens/recharge_screen.dart';
import 'package:gpay/screens/forms/transfer/llega_account_transfer_form.dart';
import 'package:gpay/screens/forms/transfer/pagomobil_transfer_form.dart';
import 'package:gpay/screens/forms/transfer/dr_transfer_form.dart';
import 'package:gpay/screens/forms/drbeneficiary_form.dart';

String flagURL = 'https://flagcdn.com/w40/do.png';
String flagURL1 = 'https://flagcdn.com/w40/gt.png';
String flagURL2 = 'https://flagcdn.com/w40/ve.png';

class InternTransferForm extends StatelessWidget {
  const InternTransferForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  child: Stack(
                    children: [
                      Positioned(
                        child: Text(
                          S.of(context).internationaltransfer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'VarelaRoundRegular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        child: SizedBox(
                          child: Image.asset(
                              'images/logos/gpay_white_logo_271x125.png'),
                          height: 140,
                          width: 140,
                        ),
                        left: (MediaQuery.of(context).size.width - 220) / 2,
                      ),
                    ],
                  ),
                  width: 500,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
              Container(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        flagURL,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        S.of(context).domrepublic,
                        style: const TextStyle(
                          color: Color(0XFF01ACCA),
                          fontFamily: 'VarelaRoundRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DrTransferForm(),
                      ),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFF01ACCA)),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
              Container(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        flagURL1,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        S.of(context).guatemala,
                        style: const TextStyle(
                          color: Color(0XFF01ACCA),
                          fontFamily: 'VarelaRoundRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LlegaAccountTransferForm(),
                      ),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFF01ACCA)),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
              Container(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        flagURL2,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        S.of(context).venezuela,
                        style: const TextStyle(
                          color: Color(0XFF01ACCA),
                          fontFamily: 'VarelaRoundRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PagoMobilPayTransferForm(),
                      ),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFF01ACCA)),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
            ],
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
