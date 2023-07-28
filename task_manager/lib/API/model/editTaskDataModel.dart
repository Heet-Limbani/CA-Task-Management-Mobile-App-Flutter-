class EditTaskDataModel {
  Data? data;
  List<Subtask>? subtask;
  List<Employee>? employee;
  List<Client>? client;
  List<Department>? department;
  List<Company>? company;
  List<File>? file;

  EditTaskDataModel(
      {this.data,
      this.subtask,
      this.employee,
      this.client,
      this.department,
      this.company,
      this.file});

  EditTaskDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['subtask'] != null) {
      subtask = <Subtask>[];
      json['subtask'].forEach((v) {
        subtask!.add(new Subtask.fromJson(v));
      });
    }
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(new Employee.fromJson(v));
      });
    }
    if (json['client'] != null) {
      client = <Client>[];
      json['client'].forEach((v) {
        client!.add(new Client.fromJson(v));
      });
    }
    if (json['department'] != null) {
      department = <Department>[];
      json['department'].forEach((v) {
        department!.add(new Department.fromJson(v));
      });
    }
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(new Company.fromJson(v));
      });
    }
    if (json['file'] != null) {
      file = <File>[];
      json['file'].forEach((v) {
        file!.add(new File.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.subtask != null) {
      data['subtask'] = this.subtask!.map((v) => v.toJson()).toList();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.map((v) => v.toJson()).toList();
    }
    if (this.client != null) {
      data['client'] = this.client!.map((v) => v.toJson()).toList();
    }
    if (this.department != null) {
      data['department'] = this.department!.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    if (this.file != null) {
      data['file'] = this.file!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? ticketId;
  String? uniqueId;
  String? createdBy;
  String? clientId;
  String? fileId;
  String? categoryId;
  String? depId;
  String? groupId;
  String? startingDate;
  String? deadlineDate;
  String? mode;
  String? title;
  String? description;
  String? status;
  String? createdOn;
  String? closedOn;
  String? updatedOn;
  String? dateOfComletion;
  String? dateOfHolding;
  String? lastReplyById;
  String? lastReplyByText;
  String? amount;
  String? transactionId;
  String? invoiceDate;
  String? invoiceNo;
  String? autoCompleteAndReview;
  String? autoInvoice;
  String? dl;

  Data(
      {this.ticketId,
      this.uniqueId,
      this.createdBy,
      this.clientId,
      this.fileId,
      this.categoryId,
      this.depId,
      this.groupId,
      this.startingDate,
      this.deadlineDate,
      this.mode,
      this.title,
      this.description,
      this.status,
      this.createdOn,
      this.closedOn,
      this.updatedOn,
      this.dateOfComletion,
      this.dateOfHolding,
      this.lastReplyById,
      this.lastReplyByText,
      this.amount,
      this.transactionId,
      this.invoiceDate,
      this.invoiceNo,
      this.autoCompleteAndReview,
      this.autoInvoice,
      this.dl});

  Data.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    uniqueId = json['unique_id'];
    createdBy = json['created_by'];
    clientId = json['client_id'];
    fileId = json['file_id'];
    categoryId = json['category_id'];
    depId = json['dep_id'];
    groupId = json['group_id'];
    startingDate = json['starting_date'];
    deadlineDate = json['deadline_date'];
    mode = json['mode'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdOn = json['created_on'];
    closedOn = json['closed_on'];
    updatedOn = json['updated_on'];
    dateOfComletion = json['date_of_comletion'];
    dateOfHolding = json['date_of_holding'];
    lastReplyById = json['last_reply_by_id'];
    lastReplyByText = json['last_reply_by_text'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    invoiceDate = json['invoice_date'];
    invoiceNo = json['invoice_no'];
    autoCompleteAndReview = json['auto_complete_and_review'];
    autoInvoice = json['auto_invoice'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['unique_id'] = this.uniqueId;
    data['created_by'] = this.createdBy;
    data['client_id'] = this.clientId;
    data['file_id'] = this.fileId;
    data['category_id'] = this.categoryId;
    data['dep_id'] = this.depId;
    data['group_id'] = this.groupId;
    data['starting_date'] = this.startingDate;
    data['deadline_date'] = this.deadlineDate;
    data['mode'] = this.mode;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['closed_on'] = this.closedOn;
    data['updated_on'] = this.updatedOn;
    data['date_of_comletion'] = this.dateOfComletion;
    data['date_of_holding'] = this.dateOfHolding;
    data['last_reply_by_id'] = this.lastReplyById;
    data['last_reply_by_text'] = this.lastReplyByText;
    data['amount'] = this.amount;
    data['transaction_id'] = this.transactionId;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_no'] = this.invoiceNo;
    data['auto_complete_and_review'] = this.autoCompleteAndReview;
    data['auto_invoice'] = this.autoInvoice;
    data['dl'] = this.dl;
    return data;
  }
}

class Subtask {
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

  Subtask(
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

  Subtask.fromJson(Map<String, dynamic> json) {
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

class Client {
  String? id;
  String? text;

  Client({this.id, this.text});

  Client.fromJson(Map<String, dynamic> json) {
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

class Department {
  String? id;
  String? name;
  String? dl;

  Department({this.id, this.name, this.dl});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dl'] = this.dl;
    return data;
  }
}

class File {
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
  String? location;

  File(
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
      this.outwardBy,
      this.location});

  File.fromJson(Map<String, dynamic> json) {
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
    location = json['location'];
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
    data['location'] = this.location;
    return data;
  }
}