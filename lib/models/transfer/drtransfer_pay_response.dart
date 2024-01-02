class DrTransferPayResponse {
  int? errorCode;
  String? transferTo;
  String? debitedAmount;
  String? fee;
  String? rate;
  String? transferAmount;
  String? transID;

  DrTransferPayResponse({
    this.errorCode,
    this.transferTo,
    this.debitedAmount,
    this.fee,
    this.rate,
    this.transferAmount,
    this.transID,
  });

  factory DrTransferPayResponse.fromJson(Map<String, dynamic> json) {
    return DrTransferPayResponse(
      errorCode: json["ErrorCode"] as int?,
      transferTo: json["TransferTo"] as String?,
      debitedAmount: json["DebitedAmount"] as String?,
      fee: json["Fee"] as String?,
      rate: json["Rate"] as String?,
      transferAmount: json["TransferAmount"] as String?,
      transID: json["TransID"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "ErrorCode": errorCode,
      "TransferTo": transferTo,
      "DebitedAmount": debitedAmount,
      "Fee": fee,
      "Rate": rate,
      "TransferAmount": transferAmount,
      "TransID": transID,
    };
    return data;
  }
}
