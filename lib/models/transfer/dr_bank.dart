class DrBank {
  String? bankID;
  String? bankName;


  DrBank({this.bankID, this.bankName});

  DrBank.fromJson(Map<String, dynamic> json) {
    bankID = json['BankID'];
    bankName = json['BankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BankID'] = this.bankID;
    data['BankName'] = this.bankName;
    return data;
  }
}
