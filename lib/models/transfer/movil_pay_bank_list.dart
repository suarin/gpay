import 'package:gpay/models/transfer/movil_pay_bank.dart';

class MovilPayBankList {
  List<MovilPayBank>? movilPayBanks;

  MovilPayBankList({this.movilPayBanks});

  MovilPayBankList.fromJson(Map<String, dynamic> json) {
    this.movilPayBanks = json["Banks"] == null
        ? null
        : (json["Banks"] as List).map((e) => MovilPayBank.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movilPayBanks != null) {
      data['Banks'] = this.movilPayBanks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
