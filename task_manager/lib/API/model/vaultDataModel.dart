class VaultDataModel {
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
  String? client;
  String? company;

  VaultDataModel(
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
      this.updatedOn,
      this.client,
      this.company});

  VaultDataModel.fromJson(Map<String, dynamic> json) {
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
    client = json['client'];
    company = json['company'];
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
    data['client'] = this.client;
    data['company'] = this.company;
    return data;
  }
}