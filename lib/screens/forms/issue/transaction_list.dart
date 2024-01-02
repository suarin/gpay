import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/card_transactions_reponse.dart';
import 'package:gpay/models/general/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionList extends StatefulWidget {
  final CardTransactionsResponse? transactionList;
  const TransactionList({Key? key, @required this.transactionList})
      : super(key: key);

  @override
  _TransactionListState createState() {
    return _TransactionListState(transactionList: this.transactionList);
  }
}

class _TransactionListState extends State<TransactionList>
    with WidgetsBindingObserver {
  final CardTransactionsResponse? transactionList;
  _TransactionListState({Key? key, @required this.transactionList});

  //Variables
  var screenSize, screenWidth, screenHeight;

  _offScanning() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isScanning', false);
  }

  @override
  void initState() {
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
          S.of(context).gpsTransactions,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'VarealRoundRegular',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SizedBox(
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
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: transactionList!.transactions!.length,
                      itemBuilder: (context, index) {
                        Transaction transaction =
                            transactionList!.transactions![index];
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  transaction.credito! > 0
                                      ? Text(
                                          '+USD ${transaction.credito}',
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontFamily: 'VarelaRoundRegular',
                                              fontSize: 20.0),
                                        )
                                      : Text(
                                          'USD ${transaction.debito}',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'VarelaRoundRegular',
                                              fontSize: 20.0),
                                        ),
                                  Text(
                                    '${transaction.fecha}',
                                    style: const TextStyle(
                                        fontFamily: 'VarelaRoundRegular',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${transaction.transaccion}',
                                        style: const TextStyle(
                                          fontFamily: 'VarelaRoundRegular',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Balance: ${transaction.saldo}',
                                        style: const TextStyle(
                                            fontFamily: 'VarelaRoundRegular',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF194D82), width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.all(5),
                          height: 140,
                        );
                      },
                    ),
                    height: screenHeight - 100,
                    width: screenWidth,
                  ),
                  top: 10,
                  left: (screenWidth - 350) / 2,
                ),
              ],
            ),
          ),
          width: screenWidth,
          height: screenHeight,
        ),
      ),
    );
  }
}
