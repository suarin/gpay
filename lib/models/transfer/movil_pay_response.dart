class MovilPayResponse {
  int? errorCode;
  String? response;
  double? totalDebit;
  String? bankCodeID;
  String? authNo;

  MovilPayResponse(
      {this.errorCode,
      this.response,
      this.totalDebit,
      this.bankCodeID,
      this.authNo});

  MovilPayResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    response = json['Response'];
    this.totalDebit = json["totalDebit"] is int ? (json['totalDebit'] as int).toDouble() : json['totalDebit'];
    bankCodeID = json['BankCodeID'];
    authNo = json['AuthNo'];
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
