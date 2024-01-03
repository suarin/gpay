
class PagoMobilPayResponse {
  int? errorCode;
  String? response;
  double? totalDebit;
  String? bankCodeID;
  String? authNo;

  PagoMobilPayResponse(
      {this.errorCode,
      this.response,
      this.totalDebit,
      this.bankCodeID,
      this.authNo});

  PagoMobilPayResponse.fromJson(Map<String, dynamic> json) {
    this.errorCode = json['ErrorCode'];
    this.response = json['Response'];
    this.totalDebit = json["totalDebit"] is int ? (json['totalDebit'] as int).toDouble() : json['totalDebit'];
    this.bankCodeID = json['BankCodeID'];
    this.authNo = json['AuthNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['Response'] = this.response;
    data['TotalDebit'] = this.totalDebit;
    data['BankCodeID'] = this.bankCodeID;
    data['AuthNo'] = this.authNo;
    return data;
  }
}
