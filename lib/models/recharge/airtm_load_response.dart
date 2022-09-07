
class AirTmLoadResponse {
  String? url;

  AirTmLoadResponse({this.url});

  AirTmLoadResponse.fromJson(Map<String, dynamic> json) {
    this.url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["url"] = this.url;
    return data;
  }
}

