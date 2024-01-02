import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/transfer/mobile_pay_response.dart';
import 'package:gpay/services/transfer_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobilePaymentWebView extends StatefulWidget {
  const MobilePaymentWebView({Key? key}) : super(key: key);

  @override
  _MobilePaymentWebViewState createState() => _MobilePaymentWebViewState();
}

class _MobilePaymentWebViewState extends State<MobilePaymentWebView> {
  bool isProcessing = true;
  MobilePayResponse? mobilePayResponse;
  String url = 'https://bgipay.me/spa/xcmo/securew/trans_movilpay.asp';

  //function to obtain bank account for picker
  _getMobilePaymentData() async {
    await TransferServices.getMobilePayment().then((res) => {
          mobilePayResponse = MobilePayResponse.fromJson(res),
          setState(() {
            url =
                'https://bgipay.me/spa/xcmo/securew/trans_movilpay.asp?CHolderID=${mobilePayResponse!.cHolderId}&Token=${mobilePayResponse!.token}';
            isProcessing = false;
          })
        });
  }

  @override
  void initState() {
    _getMobilePaymentData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return isProcessing
        ? Container(
            child: Text(
              S.of(context).processing,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'VarelaRoundRegular',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              flexibleSpace: Image.asset(
                'images/backgrounds/app_bar_header.png',
                fit: BoxFit.fill,
                height: 150.0,
              ),
              title: const Text(
                'AIRTM',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'VarealRoundRegular',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: WebView(
              initialUrl: url,
            ),
          );
  }
}
