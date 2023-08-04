class ClientPasswordEditDataModel {
  List<Data>? data;
  PerData? perData;

  ClientPasswordEditDataModel({this.data, this.perData});

  ClientPasswordEditDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    perData = json['per_data'] != null
        ? new PerData.fromJson(json['per_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.perData != null) {
      data['per_data'] = this.perData!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? text;

  Data({this.id, this.text});

  Data.fromJson(Map<String, dynamic> json) {
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

class PerData {
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

  PerData(
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

  PerData.fromJson(Map<String, dynamic> json) {
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