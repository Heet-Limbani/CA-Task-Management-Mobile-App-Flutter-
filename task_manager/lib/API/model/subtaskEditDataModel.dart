class SubtaskEditDataModel {
  List<Data>? data;
  List<Subtasks>? subtasks;
  String? lastdtst;
  String? lastdtdead;
  List<Employee>? employee;

  SubtaskEditDataModel(
      {this.data,
      this.subtasks,
      this.lastdtst,
      this.lastdtdead,
      this.employee});

  SubtaskEditDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['subtasks'] != null) {
      subtasks = <Subtasks>[];
      json['subtasks'].forEach((v) {
        subtasks!.add(new Subtasks.fromJson(v));
      });
    }
    lastdtst = json['lastdtst'];
    lastdtdead = json['lastdtdead'];
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.subtasks != null) {
      data['subtasks'] = this.subtasks!.map((v) => v.toJson()).toList();
    }
    data['lastdtst'] = this.lastdtst;
    data['lastdtdead'] = this.lastdtdead;
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? subtaskId;
  String? ticketId;
  String? empId;
  String? taxPayable;
  String? taxPayableTillDate;
  String? title;
  String? description;
  String? createdOn;
  String? deadlineDate;
  String? startingDate;
  String? updatedOn;
  String? totalHoldTime;
  String? completionTime;
  String? priority;
  String? status;
  String? dl;

  Data(
      {this.subtaskId,
      this.ticketId,
      this.empId,
      this.taxPayable,
      this.taxPayableTillDate,
      this.title,
      this.description,
      this.createdOn,
      this.deadlineDate,
      this.startingDate,
      this.updatedOn,
      this.totalHoldTime,
      this.completionTime,
      this.priority,
      this.status,
      this.dl});

  Data.fromJson(Map<String, dynamic> json) {
    subtaskId = json['subtask_id'];
    ticketId = json['ticket_id'];
    empId = json['emp_id'];
    taxPayable = json['tax_payable'];
    taxPayableTillDate = json['tax_payable_till_date'];
    title = json['title'];
    description = json['description'];
    createdOn = json['created_on'];
    deadlineDate = json['deadline_date'];
    startingDate = json['starting_date'];
    updatedOn = json['updated_on'];
    totalHoldTime = json['total_hold_time'];
    completionTime = json['completion_time'];
    priority = json['priority'];
    status = json['status'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtask_id'] = this.subtaskId;
    data['ticket_id'] = this.ticketId;
    data['emp_id'] = this.empId;
    data['tax_payable'] = this.taxPayable;
    data['tax_payable_till_date'] = this.taxPayableTillDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_on'] = this.createdOn;
    data['deadline_date'] = this.deadlineDate;
    data['starting_date'] = this.startingDate;
    data['updated_on'] = this.updatedOn;
    data['total_hold_time'] = this.totalHoldTime;
    data['completion_time'] = this.completionTime;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['dl'] = this.dl;
    return data;
  }
}

class Subtasks {
  String? subtaskId;
  String? ticketId;
  String? empId;
  String? taxPayable;
  String? taxPayableTillDate;
  String? title;
  String? description;
  String? createdOn;
  String? deadlineDate;
  String? startingDate;
  String? updatedOn;
  String? totalHoldTime;
  String? completionTime;
  String? priority;
  String? status;
  String? dl;
  String? taskTitle;
  String? firstName;
  String? lastName;

  Subtasks(
      {this.subtaskId,
      this.ticketId,
      this.empId,
      this.taxPayable,
      this.taxPayableTillDate,
      this.title,
      this.description,
      this.createdOn,
      this.deadlineDate,
      this.startingDate,
      this.updatedOn,
      this.totalHoldTime,
      this.completionTime,
      this.priority,
      this.status,
      this.dl,
      this.taskTitle,
      this.firstName,
      this.lastName});

  Subtasks.fromJson(Map<String, dynamic> json) {
    subtaskId = json['subtask_id'];
    ticketId = json['ticket_id'];
    empId = json['emp_id'];
    taxPayable = json['tax_payable'];
    taxPayableTillDate = json['tax_payable_till_date'];
    title = json['title'];
    description = json['description'];
    createdOn = json['created_on'];
    deadlineDate = json['deadline_date'];
    startingDate = json['starting_date'];
    updatedOn = json['updated_on'];
    totalHoldTime = json['total_hold_time'];
    completionTime = json['completion_time'];
    priority = json['priority'];
    status = json['status'];
    dl = json['dl'];
    taskTitle = json['TaskTitle'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtask_id'] = this.subtaskId;
    data['ticket_id'] = this.ticketId;
    data['emp_id'] = this.empId;
    data['tax_payable'] = this.taxPayable;
    data['tax_payable_till_date'] = this.taxPayableTillDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_on'] = this.createdOn;
    data['deadline_date'] = this.deadlineDate;
    data['starting_date'] = this.startingDate;
    data['updated_on'] = this.updatedOn;
    data['total_hold_time'] = this.totalHoldTime;
    data['completion_time'] = this.completionTime;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['dl'] = this.dl;
    data['TaskTitle'] = this.taskTitle;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
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