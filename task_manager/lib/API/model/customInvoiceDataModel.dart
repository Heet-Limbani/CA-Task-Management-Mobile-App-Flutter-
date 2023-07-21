class CustomInvoiceDataModel {
  String? id;
  String? clientId;
  String? amount;
  String? active;
  String? nextDate;
  String? startingDate;
  String? particular;
  String? timePeriod;
  String? dl;
  String? company;

  CustomInvoiceDataModel(
      {this.id,
      this.clientId,
      this.amount,
      this.active,
      this.nextDate,
      this.startingDate,
      this.particular,
      this.timePeriod,
      this.dl,
      this.company});

  CustomInvoiceDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    amount = json['amount'];
    active = json['active'];
    nextDate = json['next_date'];
    startingDate = json['starting_date'];
    particular = json['particular'];
    timePeriod = json['time_period'];
    dl = json['dl'];
    company = json['company'];
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
    data['company'] = this.company;
    return data;
  }
}