class CompanyCommentEditDataModel {
  List<Company>? company;
  Data? data;

  CompanyCommentEditDataModel({this.company, this.data});

  CompanyCommentEditDataModel.fromJson(Map<String, dynamic> json) {
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(new Company.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
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

class Data {
  String? id;
  String? userId;
  String? clientId;
  String? type;
  String? title;
  String? data;
  String? date;

  Data(
      {this.id,
      this.userId,
      this.clientId,
      this.type,
      this.title,
      this.data,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clientId = json['client_id'];
    type = json['type'];
    title = json['title'];
    data = json['data'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['client_id'] = this.clientId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['data'] = this.data;
    data['date'] = this.date;
    return data;
  }
}