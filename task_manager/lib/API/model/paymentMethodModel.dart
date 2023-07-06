class PaymentMethod {
  String? id;
  String? name;
  String? isFixed;
  String? dl;

  PaymentMethod({this.id, this.name, this.isFixed, this.dl});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isFixed = json['is_fixed'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_fixed'] = this.isFixed;
    data['dl'] = this.dl;
    return data;
  }
}