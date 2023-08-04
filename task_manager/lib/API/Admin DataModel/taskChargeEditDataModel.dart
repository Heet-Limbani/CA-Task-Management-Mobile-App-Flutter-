class TaskChargeEditDataModel  {
  List<Expences>? expences;
  Data? data;

  TaskChargeEditDataModel({this.expences, this.data});

  TaskChargeEditDataModel.fromJson(Map<String, dynamic> json) {
    if (json['expences'] != null) {
      expences = <Expences>[];
      json['expences'].forEach((v) {
        expences!.add(new Expences.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.expences != null) {
      data['expences'] = this.expences!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Expences {
  String? id;
  String? type;
  String? name;
  String? createdOn;
  String? dl;

  Expences({this.id, this.type, this.name, this.createdOn, this.dl});

  Expences.fromJson(Map<String, dynamic> json) {
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

class Data {
  String? id;
  String? ticketId;
  String? expenceId;
  String? amount;
  String? description;
  String? createdOn;
  String? dl;

  Data(
      {this.id,
      this.ticketId,
      this.expenceId,
      this.amount,
      this.description,
      this.createdOn,
      this.dl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    expenceId = json['expence_id'];
    amount = json['amount'];
    description = json['description'];
    createdOn = json['created_on'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['expence_id'] = this.expenceId;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['created_on'] = this.createdOn;
    data['dl'] = this.dl;
    return data;
  }
}