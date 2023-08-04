class EditCustomInvoiceDataModel {
  List<Company>? company;
  Data? data;

  EditCustomInvoiceDataModel({this.company, this.data});

  EditCustomInvoiceDataModel.fromJson(Map<String, dynamic> json) {
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
  String? clientId;
  String? amount;
  String? active;
  String? nextDate;
  String? startingDate;
  String? particular;
  String? timePeriod;
  String? dl;

  Data(
      {this.id,
      this.clientId,
      this.amount,
      this.active,
      this.nextDate,
      this.startingDate,
      this.particular,
      this.timePeriod,
      this.dl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    amount = json['amount'];
    active = json['active'];
    nextDate = json['next_date'];
    startingDate = json['starting_date'];
    particular = json['particular'];
    timePeriod = json['time_period'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['amount'] = this.amount;
    data['active'] = this.active;
    data['next_date'] = this.nextDate;
    data['starting_date'] = this.startingDate;
    data['particular'] = this.particular;
    data['time_period'] = this.timePeriod;
    data['dl'] = this.dl;
    return data;
  }
}