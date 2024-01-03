import 'package:flutter/material.dart';
import 'package:gpay/generated/l10n.dart';
import 'package:gpay/models/recharge/zelle_info_response.dart';
import 'package:gpay/screens/forms/recharge/deposit_form.dart';
import 'package:gpay/services/recharge_services.dart';

class ZelleAlert extends StatefulWidget {
  @override
  _ZelleAlertState createState() => _ZelleAlertState();
}

class _ZelleAlertState extends State<ZelleAlert> {
  ZelleInfoResponse? zelleInfoResponse;
  bool infoLoaded = false;

  //function to get Zelle Info for the Alert
  _loadZelleInfo() async {
    await RechargeServices.getZelleInfo().then((info) => {
          setState(() {
            zelleInfoResponse = ZelleInfoResponse.fromJson(info);
            infoLoaded = true;
          })
        });
  }

  @override
  void initState() {
    _loadZelleInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          height: 300.0,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              shape: BoxShape.rectangle,
              color: Color(0XFFFDFDF5)),
          child: ListTile(
            title: Text(
              S.of(context).zelleInfoTitle,
            ),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(S.of(context).zelleInfoDescription),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${S.of(context).zelleInfoEmailLabel}: ${infoLoaded ? zelleInfoResponse!.zelleEmail : "Sin dato"}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${S.of(context).zelleInfoCompanyLabel}: ${infoLoaded ? zelleInfoResponse!.companyName : "Sin dato"}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  S.of(context).zelleInfoWarning,
                  style: const TextStyle(color: Colors.redAccent),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Visibility(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.lightBlueAccent),
                    child: TextButton(
                      child: Text(
                        S.of(context).close,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DepositForm()));
                      },
                    ),
                  ),
                  visible: infoLoaded,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
