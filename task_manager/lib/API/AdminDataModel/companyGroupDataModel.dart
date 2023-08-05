class CompanyGroupDataModel {
  String? id;
  String? companyId;
  String? name;
  String? dl;
  String? message;
  String? timeInterval;
  String? generateTicket;
  String? sendSms;
  String? sendEmail;
  String? startDate;

  CompanyGroupDataModel(
      {this.id,
      this.companyId,
      this.name,
      this.dl,
      this.message,
      this.timeInterval,
      this.generateTicket,
      this.sendSms,
      this.sendEmail,
      this.startDate});

  CompanyGroupDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    dl = json['dl'];
    message = json['message'];
    timeInterval = json['time_interval'];
    generateTicket = json['generate_ticket'];
    sendSms = json['send_sms'];
    sendEmail = json['send_email'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['dl'] = this.dl;
    data['message'] = this.message;
    data['time_interval'] = this.timeInterval;
    data['generate_ticket'] = this.generateTicket;
    data['send_sms'] = this.sendSms;
    data['send_email'] = this.sendEmail;
    data['start_date'] = this.startDate;
    return data;
  }
}
