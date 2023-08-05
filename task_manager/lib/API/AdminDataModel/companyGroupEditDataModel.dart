class CompanyGroupEditDataModel {
  Group? group;
  List<Selected>? selected;
  List<Company>? company;

  CompanyGroupEditDataModel({this.group, this.selected, this.company});

  CompanyGroupEditDataModel.fromJson(Map<String, dynamic> json) {
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    if (json['selected'] != null) {
      selected = <Selected>[];
      json['selected'].forEach((v) {
        selected!.add(new Selected.fromJson(v));
      });
    }
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.selected != null) {
      data['selected'] = this.selected!.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Group {
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

  Group(
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

  Group.fromJson(Map<String, dynamic> json) {
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

class Selected {
  String? id;
  String? userId;
  String? employeeId;
  String? clientId;
  String? name;
  String? startingDate;
  String? proprietorName;
  String? mobile;
  String? email;
  String? add1;
  String? add2;
  String? state;
  String? dist;
  String? groupId;
  String? gstno;
  String? panno;
  String? ref;
  String? dl;

  Selected(
      {this.id,
      this.userId,
      this.employeeId,
      this.clientId,
      this.name,
      this.startingDate,
      this.proprietorName,
      this.mobile,
      this.email,
      this.add1,
      this.add2,
      this.state,
      this.dist,
      this.groupId,
      this.gstno,
      this.panno,
      this.ref,
      this.dl});

  Selected.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    clientId = json['client_id'];
    name = json['name'];
    startingDate = json['starting_date'];
    proprietorName = json['proprietor_name'];
    mobile = json['mobile'];
    email = json['email'];
    add1 = json['add1'];
    add2 = json['add2'];
    state = json['state'];
    dist = json['dist'];
    groupId = json['group_id'];
    gstno = json['gstno'];
    panno = json['panno'];
    ref = json['ref'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['starting_date'] = this.startingDate;
    data['proprietor_name'] = this.proprietorName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['state'] = this.state;
    data['dist'] = this.dist;
    data['group_id'] = this.groupId;
    data['gstno'] = this.gstno;
    data['panno'] = this.panno;
    data['ref'] = this.ref;
    data['dl'] = this.dl;
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