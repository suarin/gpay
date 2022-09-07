// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add Account`
  String get addAccount {
    return Intl.message(
      'Add Account',
      name: 'addAccount',
      desc: '',
      args: [],
    );
  }

  /// `Added Successfully`
  String get addedSuccessfully {
    return Intl.message(
      'Added Successfully',
      name: 'addedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Amount Debited`
  String get amountDebited {
    return Intl.message(
      'Amount Debited',
      name: 'amountDebited',
      desc: '',
      args: [],
    );
  }

  /// `Authorization`
  String get authorization {
    return Intl.message(
      'Authorization',
      name: 'authorization',
      desc: '',
      args: [],
    );
  }

  /// `Bills`
  String get bills {
    return Intl.message(
      'Bills',
      name: 'bills',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder ID`
  String get cardHolderId {
    return Intl.message(
      'Card Holder ID',
      name: 'cardHolderId',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Check Identity`
  String get checkIdentity {
    return Intl.message(
      'Check Identity',
      name: 'checkIdentity',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message(
      'Client',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Debited`
  String get debited {
    return Intl.message(
      'Debited',
      name: 'debited',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Document Type`
  String get documentType {
    return Intl.message(
      'Document Type',
      name: 'documentType',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `End Date Report`
  String get endDateReport {
    return Intl.message(
      'End Date Report',
      name: 'endDateReport',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `GPS Account`
  String get gpsAccount {
    return Intl.message(
      'GPS Account',
      name: 'gpsAccount',
      desc: '',
      args: [],
    );
  }

  /// `GPS Transactions`
  String get gpsTransactions {
    return Intl.message(
      'GPS Transactions',
      name: 'gpsTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Identification Number`
  String get identificationNumber {
    return Intl.message(
      'Identification Number',
      name: 'identificationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Inserted`
  String get inserted {
    return Intl.message(
      'Inserted',
      name: 'inserted',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Loads`
  String get loads {
    return Intl.message(
      'Loads',
      name: 'loads',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Merchant`
  String get merchant {
    return Intl.message(
      'Merchant',
      name: 'merchant',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Password`
  String get merchantPassword {
    return Intl.message(
      'Merchant Password',
      name: 'merchantPassword',
      desc: '',
      args: [],
    );
  }

  /// `Names`
  String get names {
    return Intl.message(
      'Names',
      name: 'names',
      desc: '',
      args: [],
    );
  }

  /// `New Web Pin`
  String get newWebPin {
    return Intl.message(
      'New Web Pin',
      name: 'newWebPin',
      desc: '',
      args: [],
    );
  }

  /// `No Bank Accounts`
  String get noBankAccounts {
    return Intl.message(
      'No Bank Accounts',
      name: 'noBankAccounts',
      desc: '',
      args: [],
    );
  }

  /// `No Bills`
  String get noBills {
    return Intl.message(
      'No Bills',
      name: 'noBills',
      desc: '',
      args: [],
    );
  }

  /// `No cards`
  String get noCards {
    return Intl.message(
      'No cards',
      name: 'noCards',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password Does Not Match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password Does Not Match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password Recovery`
  String get passwordRecovery {
    return Intl.message(
      'Password Recovery',
      name: 'passwordRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Processed Correctly`
  String get processedCorrectly {
    return Intl.message(
      'Processed Correctly',
      name: 'processedCorrectly',
      desc: '',
      args: [],
    );
  }

  /// `Promotional Code`
  String get promotionalCode {
    return Intl.message(
      'Promotional Code',
      name: 'promotionalCode',
      desc: '',
      args: [],
    );
  }

  /// `Province`
  String get province {
    return Intl.message(
      'Province',
      name: 'province',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postalCode {
    return Intl.message(
      'Postal Code',
      name: 'postalCode',
      desc: '',
      args: [],
    );
  }

  /// `QR Load`
  String get qrLoad {
    return Intl.message(
      'QR Load',
      name: 'qrLoad',
      desc: '',
      args: [],
    );
  }

  /// `Receiver`
  String get receiver {
    return Intl.message(
      'Receiver',
      name: 'receiver',
      desc: '',
      args: [],
    );
  }

  /// `Reference`
  String get reference {
    return Intl.message(
      'Reference',
      name: 'reference',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Password`
  String get repeatPassword {
    return Intl.message(
      'Repeat Password',
      name: 'repeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Web Pin`
  String get repeatWebPin {
    return Intl.message(
      'Repeat Web Pin',
      name: 'repeatWebPin',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Requisition`
  String get requisition {
    return Intl.message(
      'Requisition',
      name: 'requisition',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Reset Web Pin`
  String get resetWebPin {
    return Intl.message(
      'Reset Web Pin',
      name: 'resetWebPin',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get scanQr {
    return Intl.message(
      'Scan QR',
      name: 'scanQr',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Select Bank Account`
  String get selectBankAccount {
    return Intl.message(
      'Select Bank Account',
      name: 'selectBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Select Card`
  String get selectCard {
    return Intl.message(
      'Select Card',
      name: 'selectCard',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Select GPS Account`
  String get selectGpsAccount {
    return Intl.message(
      'Select GPS Account',
      name: 'selectGpsAccount',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Service Pay`
  String get servicePay {
    return Intl.message(
      'Service Pay',
      name: 'servicePay',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get shopping {
    return Intl.message(
      'Shopping',
      name: 'shopping',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Surnames`
  String get surnames {
    return Intl.message(
      'Surnames',
      name: 'surnames',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `User ID`
  String get userId {
    return Intl.message(
      'User ID',
      name: 'userId',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `To GPS Accounts`
  String get toGpsAccounts {
    return Intl.message(
      'To GPS Accounts',
      name: 'toGpsAccounts',
      desc: '',
      args: [],
    );
  }

  /// `To Mobil Pay`
  String get toMobile {
    return Intl.message(
      'To Mobil Pay',
      name: 'toMobile',
      desc: '',
      args: [],
    );
  }

  /// `To US Bank`
  String get toUSBank {
    return Intl.message(
      'To US Bank',
      name: 'toUSBank',
      desc: '',
      args: [],
    );
  }

  /// `To Virtual Card`
  String get toVirtualCard {
    return Intl.message(
      'To Virtual Card',
      name: 'toVirtualCard',
      desc: '',
      args: [],
    );
  }

  /// `To Visa Card`
  String get toVisaCard {
    return Intl.message(
      'To Visa Card',
      name: 'toVisaCard',
      desc: '',
      args: [],
    );
  }

  /// `View Transactions`
  String get viewTransactions {
    return Intl.message(
      'View Transactions',
      name: 'viewTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Virtual Card Balance`
  String get virtualCardBalance {
    return Intl.message(
      'Virtual Card Balance',
      name: 'virtualCardBalance',
      desc: '',
      args: [],
    );
  }

  /// `Virtual Card Transactions`
  String get virtualCardTransactions {
    return Intl.message(
      'Virtual Card Transactions',
      name: 'virtualCardTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Visa Balance`
  String get visaBalance {
    return Intl.message(
      'Visa Balance',
      name: 'visaBalance',
      desc: '',
      args: [],
    );
  }

  /// `Visa Request`
  String get visaRequest {
    return Intl.message(
      'Visa Request',
      name: 'visaRequest',
      desc: '',
      args: [],
    );
  }

  /// `Visa Transactions`
  String get visaTransactions {
    return Intl.message(
      'Visa Transactions',
      name: 'visaTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Voucher Load`
  String get voucherLoad {
    return Intl.message(
      'Voucher Load',
      name: 'voucherLoad',
      desc: '',
      args: [],
    );
  }

  /// `Voucher Number`
  String get voucherNumber {
    return Intl.message(
      'Voucher Number',
      name: 'voucherNumber',
      desc: '',
      args: [],
    );
  }

  /// `Wen Pin`
  String get webPin {
    return Intl.message(
      'Wen Pin',
      name: 'webPin',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Zelle Account`
  String get zelleAccount {
    return Intl.message(
      'Zelle Account',
      name: 'zelleAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
