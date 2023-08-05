class AttendanceLogEditDataModel {
  List<Employee>? employee;
  Data? data;

  AttendanceLogEditDataModel({this.employee, this.data});

  AttendanceLogEditDataModel.fromJson(Map<String, dynamic> json) {
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Employee {
  String? iD;
  String? email;
  String? password;
  String? token;
  String? iP;
  String? username;
  String? firstName;
  String? lastName;
  String? avatar;
  String? joined;
  String? joinedDate;
  String? onlineTimestamp;
  String? oauthProvider;
  String? oauthId;
  String? oauthToken;
  String? oauthSecret;
  String? emailNotification;
  Null fcmToken;
  String? aboutme;
  String? points;
  String? premiumTime;
  String? userRole;
  String? allocatedClient;
  String? premiumPlanid;
  String? active;
  String? activateCode;
  String? type;
  String? dl;
  String? contactNumber;
  String? parentNumber;
  String? sendSms;
  String? sendEmail;
  String? permission;
  String? sessionTime;

  Employee(
      {this.iD,
      this.email,
      this.password,
      this.token,
      this.iP,
      this.username,
      this.firstName,
      this.lastName,
      this.avatar,
      this.joined,
      this.joinedDate,
      this.onlineTimestamp,
      this.oauthProvider,
      this.oauthId,
      this.oauthToken,
      this.oauthSecret,
      this.emailNotification,
      this.fcmToken,
      this.aboutme,
      this.points,
      this.premiumTime,
      this.userRole,
      this.allocatedClient,
      this.premiumPlanid,
      this.active,
      this.activateCode,
      this.type,
      this.dl,
      this.contactNumber,
      this.parentNumber,
      this.sendSms,
      this.sendEmail,
      this.permission,
      this.sessionTime});

  Employee.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    iP = json['IP'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    joined = json['joined'];
    joinedDate = json['joined_date'];
    onlineTimestamp = json['online_timestamp'];
    oauthProvider = json['oauth_provider'];
    oauthId = json['oauth_id'];
    oauthToken = json['oauth_token'];
    oauthSecret = json['oauth_secret'];
    emailNotification = json['email_notification'];
    fcmToken = json['fcm_token'];
    aboutme = json['aboutme'];
    points = json['points'];
    premiumTime = json['premium_time'];
    userRole = json['user_role'];
    allocatedClient = json['allocated_client'];
    premiumPlanid = json['premium_planid'];
    active = json['active'];
    activateCode = json['activate_code'];
    type = json['type'];
    dl = json['dl'];
    contactNumber = json['contact_number'];
    parentNumber = json['parent_number'];
    sendSms = json['send_sms'];
    sendEmail = json['send_email'];
    permission = json['permission'];
    sessionTime = json['session_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;
    data['IP'] = this.iP;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    data['joined'] = this.joined;
    data['joined_date'] = this.joinedDate;
    data['online_timestamp'] = this.onlineTimestamp;
    data['oauth_provider'] = this.oauthProvider;
    data['oauth_id'] = this.oauthId;
    data['oauth_token'] = this.oauthToken;
    data['oauth_secret'] = this.oauthSecret;
    data['email_notification'] = this.emailNotification;
    data['fcm_token'] = this.fcmToken;
    data['aboutme'] = this.aboutme;
    data['points'] = this.points;
    data['premium_time'] = this.premiumTime;
    data['user_role'] = this.userRole;
    data['allocated_client'] = this.allocatedClient;
    data['premium_planid'] = this.premiumPlanid;
    data['active'] = this.active;
    data['activate_code'] = this.activateCode;
    data['type'] = this.type;
    data['dl'] = this.dl;
    data['contact_number'] = this.contactNumber;
    data['parent_number'] = this.parentNumber;
    data['send_sms'] = this.sendSms;
    data['send_email'] = this.sendEmail;
    data['permission'] = this.permission;
    data['session_time'] = this.sessionTime;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? inTime;
  String? outTime;
  String? createdOn;
  String? createdBy;
  String? dl;

  Data(
      {this.id,
      this.userId,
      this.inTime,
      this.outTime,
      this.createdOn,
      this.createdBy,
      this.dl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['dl'] = this.dl;
    return data;
  }
}