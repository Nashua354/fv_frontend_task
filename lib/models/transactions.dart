class TransactionList {
  List<Transaction>? transactions;

  TransactionList({this.transactions});

  TransactionList.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  String? name;
  String? id;
  String? cardId;
  String? category;
  String? date;
  String? status;
  String? type;
  String? expense;
  String? icon;

  Transaction(
      {this.name,
      this.id,
      this.cardId,
      this.category,
      this.date,
      this.status,
      this.type,
      this.expense,
      this.icon});

  Transaction.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    cardId = json['card_id'];
    category = json['category'];
    date = json['date'];
    status = json['status'];
    type = json['type'];
    expense = json['expense'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['card_id'] = cardId;
    data['category'] = category;
    data['date'] = date;
    data['status'] = status;
    data['type'] = type;
    data['expense'] = expense;
    data['icon'] = icon;
    return data;
  }
}
