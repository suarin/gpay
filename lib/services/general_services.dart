import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enough_convert/enough_convert.dart';
import 'api_resources.dart';

class GeneralServices {

  static Future<dynamic> getCHolderID() async{
    String reqCHolderID='0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('cHolderID') != null) {
      reqCHolderID = prefs.get('cHolderID').toString();
    }
    return reqCHolderID;
  }
  static Future<dynamic> getCustomerRegistration(
      String reqPromotionCode,
      String reqFirstName,
      String reqLastName,
      String reqMobileNo,
      String reqEmail,
      String reqCountryID,
      String reqSINTypeID,
      String reqSIN) async {
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.registrationUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqPromotionCode=$reqPromotionCode&ReqFirstName=$reqFirstName&ReqLastName=$reqLastName&ReqMobileNo=$reqMobileNo&ReqEmail=$reqEmail&ReqCountryID=$reqCountryID&ReqSINTypeID=$reqSINTypeID&ReqSIN=$reqSIN');
    //send get for registration with parameters ReqMerchantID, ReqToken, ReqFirstName, ReqLastName, ReqMobileNo, ReqEmail, ReqCountryID, ReqSINTypeID, ReqSIN

    http.Response response;
    try{
      response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );
    }catch(e){
      return 'Error en el envio http ${e.toString()}';
    }

    //Validates that http response is ok code 200

    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error en el objeto: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getLogin(
      String reqUserID,
      String reqPassword) async {
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.loginUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqUserID=$reqUserID&ReqPassword=$reqPassword');

    //send get for registration with parameters ReqMerchantID, ReqToken, ReqUserID, ReqPassword
    http.Response response;
    try{
      response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
      );
    }catch(e){
      return 'Error en el envio http ${e.toString()}';
    }

    //Validates that http response is ok code 200

    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error en el objeto: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getWebPinChange(
      String reqPassword,
      String reqPIN1,
      String reqPIN2) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.webPinChangeUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqPIN1=$reqPIN1&ReqPIN2=$reqPIN2');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getPasswordChange(
      String reqPIN1,
      String reqPIN2) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.passwordChangeUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPIN1=$reqPIN1&ReqPIN2=$reqPIN2');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }

  }

  static Future<dynamic> getVisaRequest(
      String reqPassword,
      String reqAddress,
      String reqCityID,
      String reqProvinceID,
      String reqZipCode,
      String reqPhone) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.visaRequestUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAddress=$reqAddress&ReqCityID=$reqCityID&ReqProvinceID=$reqProvinceID&ReqZipCode=$reqProvinceID&ReqPhone=$reqPhone');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }

  static Future<dynamic> getVisaBalance(
      String reqVisaCardNo) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.visaBalanceUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqVisaCardNo=$reqVisaCardNo');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }

  }

  static Future<dynamic> getVisaCards() async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.visaCardsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }


  }

  static Future<dynamic> getAddAccounts(
      String reqUserID,
      String reqFirstName,
      String reqLastName
      ) async {

    //get CHolderID
    var reqCHolderID = await getCHolderID();

    //Prepare Uri
    var url = Uri.parse ('${ApiResources.baseUri + ApiResources.addAccounts}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqUserID=$reqUserID&ReqFirstName=$reqFirstName&ReqLastName=$reqLastName');

    //Add account
    http.Response response;

    try{
      response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }

    //Validates that http response is ok code 200
    if(response.statusCode == 200){
      //if is ok return the decoded body of response returs the result of adding account
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    }

  }

  static Future<dynamic> getCardTransactions(
      String reqPassword) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.cardTransactionsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }


  }

  static Future<dynamic> getVirtualCardBalance(
      String reqVisaCardNo) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.virtualCardBalanceUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqVirtualCardNo=$reqVisaCardNo');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }

  }

  static Future<dynamic> getVirtualCards() async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.virtualCardsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }


  }

  static Future<dynamic> getBills() async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.billsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCardHolderID=$reqCHolderID');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }

  }

  static Future<dynamic> getPayBill(
      String reqInvoiceNo,
      String reqCardNumber,
      String reqPassword,
      String reqAmount,
      String reqBillerID,
      String reqAccountNo,
      String reqRushPayment,
      ) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.payBillUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqInvoiceNo=$reqInvoiceNo&ReqCardNumber=$reqCardNumber&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqBillerID=$reqBillerID&ReqAccountNo=$reqAccountNo&ReqRushPayment=$reqRushPayment');
    //Send card transfer
    http.Response response;
    try{
      response = await http.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
          }
      );
    }catch(e){
      return 'Error: ${e.toString()}';
    }
    //validates that http response is ok code 200
    if (response.statusCode == 200) {
      //if is ok return the decoded body of response, returns: CHolderID, UserName, CardNo, Currency and Balance
      const codec = Windows1252Codec(allowInvalid: false);
      final decoded = codec.decode(response.bodyBytes);
      try{
        return json.decode(decoded);
      }catch(e){
        return 'Error json decode: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }

  }

}