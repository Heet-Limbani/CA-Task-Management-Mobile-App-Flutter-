class ClientDocumentDataModel {
  CompanyData? companyData;
  List<Documents>? documents;

  ClientDocumentDataModel({this.companyData, this.documents});

  ClientDocumentDataModel.fromJson(Map<String, dynamic> json) {
    companyData = json['company_data'] != null
        ? new CompanyData.fromJson(json['company_data'])
        : null;
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companyData != null) {
      data['company_data'] = this.companyData!.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyData {
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

  CompanyData(
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

  CompanyData.fromJson(Map<String, dynamic> json) {
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

class Documents {
  String? id;
  String? locationId;
  String? locationNum;
  String? type;
  String? clientId;
  String? userId;
  String? name;
  String? inwardTime;
  String? outwardTime;
  String? showToClient;
  String? downloadable;
  String? dl;
  Null receiverName;
  Null note;
  String? outwardBy;

  Documents(
      {this.id,
      this.locationId,
      this.locationNum,
      this.type,
      this.clientId,
      this.userId,
      this.name,
      this.inwardTime,
      this.outwardTime,
      this.showToClient,
      this.downloadable,
      this.dl,
      this.receiverName,
      this.note,
      this.outwardBy});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationId = json['location_id'];
    locationNum = json['location_num'];
    type = json['type'];
    clientId = json['client_id'];
    userId = json['user_id'];
    name = json['name'];
    inwardTime = json['inward_time'];
    outwardTime = json['outward_time'];
    showToClient = json['show_to_client'];
    downloadable = json['downloadable'];
    dl = json['dl'];
    receiverName = json['receiver_name'];
    note = json['note'];
    outwardBy = json['outward_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location_id'] = this.locationId;
    data['location_num'] = this.locationNum;
    data['type'] = this.type;
    data['client_id'] = this.clientId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['inward_time'] = this.inwardTime;
    data['outward_time'] = this.outwardTime;
    data['show_to_client'] = this.showToClient;
    data['downloadable'] = this.downloadable;
    data['dl'] = this.dl;
    data['receiver_name'] = this.receiverName;
    data['note'] = this.note;
    data['outward_by'] = this.outwardBy;
    return data;
  }
}