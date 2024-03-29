import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enough_convert/enough_convert.dart';

import 'api_resources.dart';

class RechargeServices {
  static Future<dynamic> getCHolderID() async {
    String reqCHolderID = '0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('cHolderID') != null) {
      reqCHolderID = prefs.get('cHolderID').toString();
    }
    return reqCHolderID;
  }

  static Future<dynamic> getZelleInfo() async {
    //Prepare Uri
    var url = Uri.parse(
      '${ApiResources.baseUri! + ApiResources.reqZelleInfoUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqBankID=TRU',
    );

    //Send card transfer
    http.Response response;
    try {
      response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok with code 200
    if (response.statusCode == 200) {
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error al decodificar json: $decoded';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getLoadBank(String reqPassword, String reqBankID,
      String reqAmount, String reqReferenceNo, String reqSender) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.loadBkUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqBankID=$reqBankID&ReqAmount=$reqAmount&ReqReferenceNo=$reqReferenceNo&ReqSender=$reqSender');
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

  static Future<dynamic> getCardLoadVoucher(
      String reqMMerchantID,
      String reqPaymentTypeID,
      String reqVoucherNumber,
      String reqCardNumber,
      String reqMobileNo) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.cardLoadVoucherUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqMMerchantID=$reqMMerchantID&ReqPaymentTypeID=$reqPaymentTypeID&ReqVoucherNumber=$reqVoucherNumber&ReqCardNumber=$reqCardNumber&ReqMobileNo=$reqMobileNo');

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

  static Future<String> getLoadPaySafe(String reqAmount) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.loadPaySafeUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqAmount=$reqAmount');

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
      return response.body;
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getLoadPaySafeRequest(String reqAmount) async {
    //Get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.loadPaySafeRequestUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqAmount=$reqAmount');
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    if (response.statusCode == 200) {
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json decodee: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getLoadPaySafeCodeRequest(
      String reqAmount, String reqPayToken) async {
    //Get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.paySafeCodeRequestUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqAmount=$reqAmount&ReqPayToken=$reqPayToken');
    http.Response response;
    try {
      response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      });
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
    if (response.statusCode == 200) {
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try {
        return json.decode(decoded);
      } catch (e) {
        return 'Error json decodee: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getCardLoadCash(
      String reqMMerchantID,
      String reqMPassw,
      String reqCardNumber,
      String reqMobileNo,
      String reqAmount) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.cardLoadCashUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqMMerchantID=$reqMMerchantID&ReqMPassw=$reqMPassw&ReqCardNumber=$reqCardNumber&ReqMobileNo=$reqMobileNo&ReqAmount=$reqAmount');

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

  static Future<dynamic> getLoadAirTm(
      String reqPassword, String reqTotal) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.loadAirTm}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqTotal=$reqTotal&ReqURLAprobe=https://bgipay.me/airtm&ReqURLDenay=https://bgipay.me/airtm');
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
      return jsonDecode(response.body);
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getLoadPayPal(
      String reqPassword, String reqTotal, String reqReference) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.loadPayPal}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqTotal&ReqReferenceNo=$reqReference');
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
      return jsonDecode(response.body);
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getLoadCashApp(
      String reqPassword, String reqTotal, String reqReference) async {
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse(
        '${ApiResources.baseUri! + ApiResources.loadCashAppUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqTotal&ReqReferenceNo=$reqReference');
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
      return jsonDecode(response.body);
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }
}
