import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enough_convert/enough_convert.dart';

import 'api_resources.dart';

class TransferServices {

  static Future<dynamic> getCHolderID() async{
    String reqCHolderID='0';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get('cHolderID') != null) {
      reqCHolderID = prefs.get('cHolderID').toString();
    }
    return reqCHolderID;
  }

  static Future<dynamic> getCardTransfer(
      String reqPassword,
      String reqCardNumberTo,
      String reqStrTotal,
      String notes) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.cardTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqStrTotal=$reqStrTotal&ReqCardNumberTo=$reqCardNumberTo&Notes=$notes');
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
        return 'Error en el objeto: ${e.toString()}';
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
        return 'Error json deoce: ${e.toString()}';
      }
    } else {
      return 'Error en el servidor: ${response.body}';
    }
  }
  static Future<dynamic> getBgpAccounts() async{
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.bgpAccountsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');

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
  static Future<dynamic> getVisaLoad(
      String reqPassword,
      String reqAmount,
      String reqVisaCardNumber,) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.visaLoadUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqVisaCardNumber=$reqVisaCardNumber');

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

  static Future<dynamic> getBankAccounts() async{
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.bankAccountsUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');

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

  static Future<dynamic> getMobilePayment() async{
    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.mobileTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID');
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

  static Future<dynamic> getBankTransfer(
      String reqPassword,
      String reqAmount,
      String reqBankID,
      String reqNotes) async{

    //get CHolderID
    var reqCHolderID = await getCHolderID();
    //Prepare Uri
    var url = Uri.parse('${ApiResources.baseUri + ApiResources.bankTransferUri}?ReqMerchantID=${ApiResources.reqMerchantID}&ReqToken=${ApiResources.reqToken}&ReqCHolderID=$reqCHolderID&ReqPassword=$reqPassword&ReqAmount=$reqAmount&ReqBankID=$reqBankID&ReqNotes=$reqNotes');
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
}