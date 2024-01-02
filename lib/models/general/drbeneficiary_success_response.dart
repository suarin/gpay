class DrbenefSuccessResponse {
  int? errorCode;
  int? benefId;

  DrbenefSuccessResponse({this.errorCode, this.benefId});

  DrbenefSuccessResponse.fromJson(Map<String, dynamic> json) {
    this.errorCode = json["ErrorCode"];
    this.benefId = json["Benefid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ErrorCode"] = this.errorCode;
    data["Benefid"] = this.benefId;
    return data;
  }
}