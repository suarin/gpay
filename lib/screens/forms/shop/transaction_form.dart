import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/general/transaction.dart';
import 'package:gpay/models/shop/virtual_transaction.dart';
import 'package:gpay/models/shop/virtual_transactions_response.dart';
import 'package:gpay/models/transfer/cards.dart';
import 'package:gpay/models/transfer/plastic_card.dart';
import 'package:gpay/services/general_services.dart';
import 'package:gpay/services/purchase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm>
    with WidgetsBindingObserver {
  //Variables
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _endDateController = TextEditingController();
  bool transactionsLoaded = false;
  bool isProcessing = false;
  bool showButton = true;
  bool cardsLoaded = false;
  Transaction? transaction;
  VirtualTransactionsResponse? virtualTransactionsResponse;
  PlasticCard? selectedCard;
  Cards? cards;

  var screenSize, screenWidth, screenHeight;

  //function to obtain bank account for picker
  _getVirtualCard() async {
    await GeneralServices.getVirtualCards().then((list) => {
          setState(() {
            cards = Cards.fromJson(list);
            cardsLoaded = true;
          })
        });
  }

  //Functions for dialogs
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

  //Reset Form
  _resetForm() {
    setState(() {
      isProcessing = false;
      if (transactionsLoaded) {
        showButton = false;
      } else {
        showButton = true;
      }
    });
  }

  //Function to obtain transactions
  _getTransactions() async {
    setState(() {
      isProcessing = true;
      showButton = false;
    });
    await PurchaseService.getVirtualTransactions(
            selectedCard!.cardNo.toString(), _endDateController.text)
        .then((list) => {
              virtualTransactionsResponse =
                  VirtualTransactionsResponse.fromJson(list),
              setState(() {
                transactionsLoaded = true;
              })
            })
        .catchError((error) {
      _showErrorResponse(context, error.toString());
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
    _offScanning();
    _getVirtualCard();
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
          S.of(context).virtualCardTransactions,
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
                          Visibility(
                            child: cardsLoaded
                                ? Container(
                                    child: DropdownButton<PlasticCard>(
                                      hint: Text(
                                        S.of(context).selectCard,
                                        style: const TextStyle(
                                          color: Colors.black26,
                                          fontFamily: 'VarelaRoundRegular',
                                        ),
                                      ),
                                      value: selectedCard,
                                      onChanged: (PlasticCard? value) {
                                        setState(() {
                                          selectedCard = value;
                                        });
                                      },
                                      items: cards!.cards!
                                          .map((PlasticCard plasticCard) {
                                        return DropdownMenuItem<PlasticCard>(
                                          value: plasticCard,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            width: 250,
                                            child: Text(
                                              '******${plasticCard.cardNo!.substring(12)} ${plasticCard.holderName}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    'VarelaRoundRegular',
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
                                            S.of(context).noCards,
                                            style: const TextStyle(
                                              color: Colors.black26,
                                              fontFamily: 'VarelaRoundRegular',
                                            ),
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.phone,
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
                            visible: !transactionsLoaded,
                          ),
                          Visibility(
                            child: Container(
                              child: TextButton(
                                child: TextFormField(
                                  controller: _endDateController,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).endDateReport,
                                    hintStyle: const TextStyle(
                                      color: Colors.black26,
                                      fontFamily: 'VarelaRoundRegular',
                                    ),
                                  ),
                                  enabled: false,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'VarelaRoundRegular',
                                  ),
                                ),
                                onPressed: () async {
                                  DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030));
                                  if (picked != null) {
                                    setState(() => _endDateController.text =
                                        picked.month.toString() +
                                            '/' +
                                            picked.day.toString() +
                                            '/' +
                                            picked.year.toString());
                                  }
                                },
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
                            visible: !transactionsLoaded,
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
                                  _getTransactions();
                                },
                              ),
                              decoration: const BoxDecoration(
                                  color: Color(0xFF00CAB2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              width: 300.0,
                            ),
                            visible: showButton,
                          ),
                          transactionsLoaded
                              ? SizedBox(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: virtualTransactionsResponse!
                                          .transacciones!.length,
                                      itemBuilder: (context, index) {
                                        VirtualTransaction virtualTransaction =
                                            virtualTransactionsResponse!
                                                .transacciones![index];
                                        return Container(
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      child: Text(
                                                        'ID: ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        virtualTransaction.id
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .description,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        virtualTransaction
                                                            .description
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        '${S.of(context).reference}: ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        virtualTransaction
                                                            .reference
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        '${S.of(context).amount}: ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        'USD ${virtualTransaction.amt.toString()}',
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        '${S.of(context).inserted}: ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        virtualTransaction
                                                            .inserted
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        '${S.of(context).merchant} ID: ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        virtualTransaction
                                                            .merchant
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        '${S.of(context).authorization}: ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                      width: 100,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        virtualTransaction
                                                            .authno
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'VarelaRoundRegular',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                ),
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF194D82),
                                                width: 2.0),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15.0)),
                                            color: Colors.white,
                                          ),
                                          margin: const EdgeInsets.all(5),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          width: 300,
                                          height: 200,
                                        );
                                      }),
                                  height: screenHeight - 100,
                                  width: screenWidth,
                                )
                              : const Text('')
                        ],
                      ),
                      height: screenHeight,
                      width: 300,
                    ),
                    top: 10,
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
