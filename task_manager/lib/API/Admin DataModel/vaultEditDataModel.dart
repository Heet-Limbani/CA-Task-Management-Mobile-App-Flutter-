class VaultEditDataModel {
  Data? data;
  List<Company>? company;

  VaultEditDataModel({this.data, this.company});

  VaultEditDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? type;
  String? userId;
  String? companyId;
  String? name;
  String? username;
  String? email;
  String? number;
  String? password;
  String? dl;
  String? notes;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  Data(
      {this.id,
      this.type,
      this.userId,
      this.companyId,
      this.name,
      this.username,
      this.email,
      this.number,
      this.password,
      this.dl,
      this.notes,
      this.createdOn,
      this.updatedBy,
      this.updatedOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    companyId = json['company_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    number = json['number'];
    password = json['password'];
    dl = json['dl'];
    notes = json['notes'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['number'] = this.number;
    data['password'] = this.password;
    data['dl'] = this.dl;
    data['notes'] = this.notes;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}

class Company {
  String? id;
  String? text;

  Company({this.id, this.text});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}