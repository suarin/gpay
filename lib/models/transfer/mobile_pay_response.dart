class MobilePayResponse {
  int? errorCode;
  String? cHolderId;
  String? token;
  String? authUrl;

  MobilePayResponse({this.errorCode, this.cHolderId, this.token, this.authUrl});

  MobilePayResponse.fromJson(Map<String, dynamic> json) {
    this.errorCode = json["ErrorCode"];
    this.cHolderId = json["CHolderID"];
    this.token = json["Token"];
    this.authUrl = json["AuthURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ErrorCode"] = this.errorCode;
    data["CHolderID"] = this.cHolderId;
    data["Token"] = this.token;
    data["AuthURL"] = this.authUrl;
    return data;
  }
}