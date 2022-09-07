import 'plastic_card.dart';

class Cards {
  List<PlasticCard>? cards;

  Cards({this.cards});

  Cards.fromJson(Map<String, dynamic> json) {
    this.cards = json["Cards"]==null ? null : (json["Cards"] as List).map((e)=>PlasticCard.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.cards != null)
      data["Cards"] = this.cards?.map((e)=>e.toJson()).toList();
    return data;
  }
}