class CompanyDataModel3 {
  List<Employee>? employee;
  Company? company;

  CompanyDataModel3({this.employee, this.company});

  CompanyDataModel3.fromJson(Map<String, dynamic> json) {
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
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
  Null? fcmToken;
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

class Company {
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

  Company(
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

  Company.fromJson(Map<String, dynamic> json) {
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
