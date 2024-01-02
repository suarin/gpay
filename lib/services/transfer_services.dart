import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:gpay/services/api_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enough_convert/enough_convert.dart';

import 'api_resources.dart';

class TransferServices {
  static Future<dynamic> getCHolderID() async {
    String reqCHolderID = '0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('cHolderID') != null) {
      reqCHolderID = prefs.get('cHolderID').toString();
    }
    return reqCHolderID;
  }

  static Future<dynamic> reqMerchantID() async {
    var merchantScope = '0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('merchantId') != null) {
      merchantScope = dotenv.env[prefs.getString('merchantId')]!;
    }
    return merchantScope;
  }

  static Future<dynamic> reqToken() async {
    var tokenScope = '0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('token') != null) {
      tokenScope = dotenv.env[prefs.getString('token')]!;
    }
    return tokenScope;
  }

  static Future<dynamic> getBaseUrl() async {
    var baseUrlScope = '0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('baseUrl') != null) {
      baseUrlScope = dotenv.env[prefs.getString('baseUrl')]!;
    }
    return baseUrlScope;
  }

  static Future<dynamic> getCardTransfer(String reqPassword,
      String reqCardNumberTo, String reqStrTotal, String notes) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.cardTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqStrTotal=$reqStrTotal&ReqCardNumberTo=$reqCardNumberTo&Notes=$notes');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error en el objeto: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getCardTransferInt(String reqPassword,
      String reqCardNumberTo, String reqStrTotal, String notes) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.cardTansferIntUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqStrTotal=$reqStrTotal&ReqCardNumberTo=$reqCardNumberTo&Notes=$notes');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error en el objeto: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getVisaCards() async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.visaCardsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getBgpAccounts() async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.bgpAccountsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');

    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getVisaLoad(
    String reqPassword,
    String reqAmount,
    String reqVisaCardNumber,
  ) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.visaLoadUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqVisaCardNumber=$reqVisaCardNumber');

    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);

      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getVirtualCardLoad(
    String reqPassword,
    String reqAmount,
    String reqVisaCardNumber,
  ) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.virtualCardLoadUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqVirtualCardNumber=$reqVisaCardNumber');

    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);

      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getBankAccounts() async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.bankAccountsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');

    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);

      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getMovilPayBanks() async {
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.movilPayBanksUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance

      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);

      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getDrBanks() async {
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.drBanksUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}');
    //Send request
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance

      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);

      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getMobilePayment() async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.mobileTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getMovilPay(
    String reqPassword,
    String reqAmount,
    String reqRecipient,
    String reqBankID,
    String reqMessage,
  ) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.movilPayUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqRecipient=$reqRecipient&ReqBankID=$reqBankID&ReqMessage=$reqMessage');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getIntMovilPay(
      String reqPassword,
      String reqAmount,
      String reqRecipient,
      String reqBankID,
      String reqSIN,
      ) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.intmovilPayUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqRecipient=$reqRecipient&ReqBankID=$reqBankID&ReqSIN=$reqSIN');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getDrBankTransfer(
      String reqPassword,
      String reqAmount,
      String reqRecipient,
      String reqCustName,
      ) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.bankDrTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqStrTotal=$reqAmount&ReqAccessValue=$reqRecipient&ReqCustFullName=$reqCustName');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getBankTransfer(String reqPassword, String reqAmount,
      String reqBankID, String reqNotes) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.bankTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqBankID=$reqBankID&ReqNotes=$reqNotes');
    //Send card transfer
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }
}
