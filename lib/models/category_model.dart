class CategoryList {
  List<CategoryModel>? categories;

  CategoryList({this.categories});

  CategoryList.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryModel {
  String? name;
  String? id;
  String? icon;
  String? spendPercentage;
  String? expense;

  CategoryModel(
      {this.name, this.id, this.icon, this.spendPercentage, this.expense});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    icon = json['icon'];
    spendPercentage = json['spend_percentage'];
    expense = json['expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['icon'] = icon;
    data['spend_percentage'] = spendPercentage;
    data['expense'] = expense;
    return data;
  }
}
