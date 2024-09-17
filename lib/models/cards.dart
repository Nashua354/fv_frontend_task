class CardList {
  List<CardModel>? cards;

  CardList({this.cards});

  CardList.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = <CardModel>[];
      json['cards'].forEach((v) {
        cards!.add(CardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cards != null) {
      data['cards'] = cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardModel {
  String? imageUrl;
  String? id;
  String? type;
  String? name;
  String? cardLast4;
  String? expense;
  String? totalLimit;

  CardModel(
      {this.imageUrl,
      this.id,
      this.type,
      this.name,
      this.cardLast4,
      this.expense,
      this.totalLimit});

  CardModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
    type = json['type'];
    name = json['name'];
    cardLast4 = json['cardLast4'];
    expense = json['expense'];
    totalLimit = json['total_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['cardLast4'] = cardLast4;
    data['expense'] = expense;
    data['total_limit'] = totalLimit;
    return data;
  }
}
