import 'package:gpay/models/dr_benef.dart';

class DrBenefList {
  List<DrBenef>? DrBeneficiaries;

  DrBenefList({this.DrBeneficiaries});

  DrBenefList.fromJson(Map<String, dynamic> json) {
    this.DrBeneficiaries = json["Beneficiaries"] == null
        ? null
        : (json["Beneficiaries"] as List).map((e) => DrBenef.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.DrBeneficiaries != null) {
      data['Beneficiaries'] = this.DrBeneficiaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
