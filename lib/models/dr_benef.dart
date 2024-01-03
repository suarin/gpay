class DrBenef {
  String? benefID;
  String? benefName;


  DrBenef({this.benefID, this.benefName});

  DrBenef.fromJson(Map<String, dynamic> json) {
    benefID = json['BenefID'];
    benefName = json['BenefName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BenefID'] = this.benefID;
    data['BenefName'] = this.benefName;
    return data;
  }
}
