class MovilPayBank {
  int? iD;
  String? bankID;
  String? bankName;
  String? bankCode;

  MovilPayBank({this.iD, this.bankID, this.bankName, this.bankCode});

  MovilPayBank.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    bankID = json['BankID'];
    bankName = json['BankName'];
    bankCode = json['BankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['BankID'] = this.bankID;
    data['BankName'] = this.bankName;
    data['BankCode'] = this.bankCode;
    return data;
  }
}
