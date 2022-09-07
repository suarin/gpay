class ApiResources {
  //Static parameters for MerchantID and Token
  static const String reqMerchantID = '210';
  static const String reqToken = 'yRR80PxGZxB0Zz1P';

  //Host and alias of the backend
  static const String baseUri = 'https://bgipay.me/APIMobile/';

  //General Services
  //Create account
  static const String registrationUri = 'customer/register';

  //Login
  static const String loginUri = 'customer/login';

  //Web pin change
  static const String webPinChangeUri = 'customer/webpin';

  //Password change
  static const String passwordChangeUri = 'customer/password';

  //Visa request
  static const String visaRequestUri = 'card/visarequest';

  //Visa Balance
  static const String visaBalanceUri = 'plastic_card/balance';

  //Visa Cards
  static const String visaCardsUri ='plastic_card/cards';

  //Card/BGP Transactions
  static const String cardTransactionsUri ='card/tranreport';

  //Virtual Card Balance
  static const String virtualCardBalanceUri ='virtual_card/balance';

  //Virtual Cards
  static const String virtualCardsUri = 'virtual_card/cards';

  //Bills
  static const String billsUri = 'customer/billpay_request';

  //Pay Bill
  static const String payBillUri ='customer/billpay_confirm';

  //Add Accounts
  static const String addAccounts = 'Card/GpsAddAccounts';

  //Transfers
  //Obtener listado de tarjetas Visa
  static const String plasticCardsUri = 'plastic_card/cards';

  //Card Transfer: This method is used to transfer funds from one account/card to another account/card.
  static const String cardTransferUri = 'card/transfer';

  //Visa Transfer: This method is used to transfer money from customer’s account to the Pre-Paid Visa GPS PAY Card.
  static const String visaLoadUri = 'Card/visaload';

  //Bank Accounts
  static const String bankAccountsUri = 'card/bankaccounts';

  //Bank Transfer
  static const String bankTransferUri = 'card/banktransfer';

  //Mobile payment
  static const String mobileTransferUri = 'card/movilpay';

  //Get BGP Accounts
  static const String bgpAccountsUri='card/bgpaccounts';

  //Recharge
  //Deposit Zelle: This method is used to load the customer account/card from domestic bank account
  static const String loadBkUri = 'Card/Loadbk';
  //Merchant with voucher
  static const String cardLoadVoucherUri = 'merchant/card_loadvoucher';

  //Merchant with QR
  static const String cardLoadCashUri ='merchant/card_loadcash';

  //Paysafe
  static const String loadPaySafeUri = 'card/loadpaysafe';

  //AirTm
  static const String loadAirTm = 'card/airtm';



  //Purchase
  //Qr Purchase
  static const String qrPayUri ='card/qrpay';

  //Virtual Card Transactions
  static const String virtualCardTransactionsUri = 'virtual_card/trans';

  //Visa Card Transactions
  static const String visaCardTransactionsUri = 'plastic_card/trans';
}