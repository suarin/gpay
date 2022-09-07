
class Response {
  int? errorCode;

  Response({this.errorCode});

  Response.fromJson(Map<String, dynamic> json) {
    this.errorCode = json["ErrorCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ErrorCode"] = this.errorCode;
    return data;
  }
}