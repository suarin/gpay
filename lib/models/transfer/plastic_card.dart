class PlasticCard {
  String? cardNo;
  String? holderName;

  PlasticCard({this.cardNo, this.holderName});

  PlasticCard.fromJson(Map<String, dynamic> json) {
    this.cardNo = json["CardNo"];
    this.holderName = json["HolderName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["CardNo"] = this.cardNo;
    data["HolderName"] = this.holderName;
    return data;
  }
}