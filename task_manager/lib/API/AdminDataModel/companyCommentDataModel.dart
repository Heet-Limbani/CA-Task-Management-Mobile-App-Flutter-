class CompanyCommentDataModel {
  String? id;
  String? userId;
  String? clientId;
  String? type;
  String? title;
  String? data;
  String? date;
  String? name;

  CompanyCommentDataModel(
      {this.id,
      this.userId,
      this.clientId,
      this.type,
      this.title,
      this.data,
      this.date,
      this.name});

  CompanyCommentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    clientId = json['client_id'];
    type = json['type'];
    title = json['title'];
    data = json['data'];
    date = json['date'];
    name = json['name'];
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
    data['name'] = this.name;
    return data;
  }
}