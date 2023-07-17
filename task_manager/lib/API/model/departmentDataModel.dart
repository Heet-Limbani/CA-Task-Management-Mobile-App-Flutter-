class DepartmentDataModel {
  String? id;
  String? name;
  String? dl;

  DepartmentDataModel({this.id, this.name, this.dl});

  DepartmentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dl'] = this.dl;
    return data;
  }
}