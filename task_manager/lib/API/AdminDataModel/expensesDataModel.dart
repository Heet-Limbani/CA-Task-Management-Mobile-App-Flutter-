class Expense {
  String? id;
  String? type;
  String? name;
  String? createdOn;
  String? dl;

  Expense({this.id, this.type, this.name, this.createdOn, this.dl});

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    createdOn = json['created_on'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['created_on'] = this.createdOn;
    data['dl'] = this.dl;
    return data;
  }
}