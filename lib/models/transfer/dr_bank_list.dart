import 'package:gpay/models/transfer/dr_bank.dart';

class DrBankList {
  List<DrBank>? DrBanks;

  DrBankList({this.DrBanks});

  DrBankList.fromJson(Map<String, dynamic> json) {
    this.DrBanks = json["Accounts"] == null
        ? null
        : (json["Accounts"] as List).map((e) => DrBank.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.DrBanks != null) {
      data['Accounts'] = this.DrBanks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
