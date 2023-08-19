class EmployeeDashboardDataModel {
  List<Tasks>? tasks;
  List<Pending>? pending;
  List<TotalOverdueTask>? totalOverdueTask;
  List<TotalHoldTask>? totalHoldTask;
  List<TotalQueryRaised>? totalQueryRaised;
  int? getTotalDoneTask;
  int? getTotalCompleted;
  int? completedTaskOnTime;
  List<GraphData>? graphData;
  LoginTime? loginTime;
  List<Holiday>? holiday;

  EmployeeDashboardDataModel(
      {this.tasks,
      this.pending,
      this.totalOverdueTask,
      this.totalHoldTask,
      this.totalQueryRaised,
      this.getTotalDoneTask,
      this.getTotalCompleted,
      this.completedTaskOnTime,
      this.graphData,
      this.loginTime,
      this.holiday});

  EmployeeDashboardDataModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
    if (json['total_overdue_task'] != null) {
      totalOverdueTask = <TotalOverdueTask>[];
      json['total_overdue_task'].forEach((v) {
        totalOverdueTask!.add(new TotalOverdueTask.fromJson(v));
      });
    }
    if (json['total_hold_task'] != null) {
      totalHoldTask = <TotalHoldTask>[];
      json['total_hold_task'].forEach((v) {
        totalHoldTask!.add(new TotalHoldTask.fromJson(v));
      });
    }
    if (json['total_query_raised'] != null) {
      totalQueryRaised = <TotalQueryRaised>[];
      json['total_query_raised'].forEach((v) {
        totalQueryRaised!.add(new TotalQueryRaised.fromJson(v));
      });
    }
    getTotalDoneTask = json['get_total_done_task'];
    getTotalCompleted = json['get_total_completed'];
    completedTaskOnTime = json['completed_task_on_time'];
    if (json['graph_data'] != null) {
      graphData = <GraphData>[];
      json['graph_data'].forEach((v) {
        graphData!.add(new GraphData.fromJson(v));
      });
    }
    loginTime = json['login_time'] != null
        ? new LoginTime.fromJson(json['login_time'])
        : null;
    if (json['holiday'] != null) {
      holiday = <Holiday>[];
      json['holiday'].forEach((v) {
        holiday!.add(new Holiday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    if (this.totalOverdueTask != null) {
      data['total_overdue_task'] =
          this.totalOverdueTask!.map((v) => v.toJson()).toList();
    }
    if (this.totalHoldTask != null) {
      data['total_hold_task'] =
          this.totalHoldTask!.map((v) => v.toJson()).toList();
    }
    if (this.totalQueryRaised != null) {
      data['total_query_raised'] =
          this.totalQueryRaised!.map((v) => v.toJson()).toList();
    }
    data['get_total_done_task'] = this.getTotalDoneTask;
    data['get_total_completed'] = this.getTotalCompleted;
    data['completed_task_on_time'] = this.completedTaskOnTime;
    if (this.graphData != null) {
      data['graph_data'] = this.graphData!.map((v) => v.toJson()).toList();
    }
    if (this.loginTime != null) {
      data['login_time'] = this.loginTime!.toJson();
    }
    if (this.holiday != null) {
      data['holiday'] = this.holiday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
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
  String? ctitle;
  String? cstatus;
  String? subtaskId;
  String? cdeadlineDate;
  String? priority;
  String? clientName;
  String? employeeName;
  String? taskCompletePercentage;

  Tasks(
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
      this.dl,
      this.ctitle,
      this.cstatus,
      this.subtaskId,
      this.cdeadlineDate,
      this.priority,
      this.clientName,
      this.employeeName,
      this.taskCompletePercentage});

  Tasks.fromJson(Map<String, dynamic> json) {
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
    ctitle = json['ctitle'];
    cstatus = json['cstatus'];
    subtaskId = json['subtask_id'];
    cdeadlineDate = json['cdeadline_date'];
    priority = json['priority'];
    clientName = json['client_name'];
    employeeName = json['employee_name'];
    taskCompletePercentage = json['task_complete_percentage'];
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
    data['ctitle'] = this.ctitle;
    data['cstatus'] = this.cstatus;
    data['subtask_id'] = this.subtaskId;
    data['cdeadline_date'] = this.cdeadlineDate;
    data['priority'] = this.priority;
    data['client_name'] = this.clientName;
    data['employee_name'] = this.employeeName;
    data['task_complete_percentage'] = this.taskCompletePercentage;
    return data;
  }
}

class Pending {
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
  String? ctitle;
  String? cstatus;
  String? subtaskId;
  String? cdeadlineDate;
  String? priority;
  String? clientName;
  String? employeeName;
  String? taskCompletePercentage;

  Pending(
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
      this.dl,
      this.ctitle,
      this.cstatus,
      this.subtaskId,
      this.cdeadlineDate,
      this.priority,
      this.clientName,
      this.employeeName,
      this.taskCompletePercentage});

  Pending.fromJson(Map<String, dynamic> json) {
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
    ctitle = json['ctitle'];
    cstatus = json['cstatus'];
    subtaskId = json['subtask_id'];
    cdeadlineDate = json['cdeadline_date'];
    priority = json['priority'];
    clientName = json['client_name'];
    employeeName = json['employee_name'];
    taskCompletePercentage = json['task_complete_percentage'];
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
    data['ctitle'] = this.ctitle;
    data['cstatus'] = this.cstatus;
    data['subtask_id'] = this.subtaskId;
    data['cdeadline_date'] = this.cdeadlineDate;
    data['priority'] = this.priority;
    data['client_name'] = this.clientName;
    data['employee_name'] = this.employeeName;
    data['task_complete_percentage'] = this.taskCompletePercentage;
    return data;
  }
}

class TotalOverdueTask {
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
  String? ctitle;
  String? cstatus;
  String? subtaskId;
  String? cdeadlineDate;
  String? priority;
  String? clientName;
  String? employeeName;
  String? taskCompletePercentage;

  TotalOverdueTask(
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
      this.dl,
      this.ctitle,
      this.cstatus,
      this.subtaskId,
      this.cdeadlineDate,
      this.priority,
      this.clientName,
      this.employeeName,
      this.taskCompletePercentage});

  TotalOverdueTask.fromJson(Map<String, dynamic> json) {
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
    ctitle = json['ctitle'];
    cstatus = json['cstatus'];
    subtaskId = json['subtask_id'];
    cdeadlineDate = json['cdeadline_date'];
    priority = json['priority'];
    clientName = json['client_name'];
    employeeName = json['employee_name'];
    taskCompletePercentage = json['task_complete_percentage'];
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
    data['ctitle'] = this.ctitle;
    data['cstatus'] = this.cstatus;
    data['subtask_id'] = this.subtaskId;
    data['cdeadline_date'] = this.cdeadlineDate;
    data['priority'] = this.priority;
    data['client_name'] = this.clientName;
    data['employee_name'] = this.employeeName;
    data['task_complete_percentage'] = this.taskCompletePercentage;
    return data;
  }
}

class TotalHoldTask {
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
  String? ctitle;
  String? cstatus;
  String? subtaskId;
  String? cdeadlineDate;
  String? priority;
  String? clientName;
  String? employeeName;
  String? taskCompletePercentage;

  TotalHoldTask(
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
      this.dl,
      this.ctitle,
      this.cstatus,
      this.subtaskId,
      this.cdeadlineDate,
      this.priority,
      this.clientName,
      this.employeeName,
      this.taskCompletePercentage});

  TotalHoldTask.fromJson(Map<String, dynamic> json) {
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
    ctitle = json['ctitle'];
    cstatus = json['cstatus'];
    subtaskId = json['subtask_id'];
    cdeadlineDate = json['cdeadline_date'];
    priority = json['priority'];
    clientName = json['client_name'];
    employeeName = json['employee_name'];
    taskCompletePercentage = json['task_complete_percentage'];
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
    data['ctitle'] = this.ctitle;
    data['cstatus'] = this.cstatus;
    data['subtask_id'] = this.subtaskId;
    data['cdeadline_date'] = this.cdeadlineDate;
    data['priority'] = this.priority;
    data['client_name'] = this.clientName;
    data['employee_name'] = this.employeeName;
    data['task_complete_percentage'] = this.taskCompletePercentage;
    return data;
  }
}

class TotalQueryRaised {
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
  String? ctitle;
  String? cstatus;
  String? subtaskId;
  String? cdeadlineDate;
  String? priority;
  String? clientName;
  String? employeeName;
  String? taskCompletePercentage;

  TotalQueryRaised(
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
      this.dl,
      this.ctitle,
      this.cstatus,
      this.subtaskId,
      this.cdeadlineDate,
      this.priority,
      this.clientName,
      this.employeeName,
      this.taskCompletePercentage});

  TotalQueryRaised.fromJson(Map<String, dynamic> json) {
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
    ctitle = json['ctitle'];
    cstatus = json['cstatus'];
    subtaskId = json['subtask_id'];
    cdeadlineDate = json['cdeadline_date'];
    priority = json['priority'];
    clientName = json['client_name'];
    employeeName = json['employee_name'];
    taskCompletePercentage = json['task_complete_percentage'];
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
    data['ctitle'] = this.ctitle;
    data['cstatus'] = this.cstatus;
    data['subtask_id'] = this.subtaskId;
    data['cdeadline_date'] = this.cdeadlineDate;
    data['priority'] = this.priority;
    data['client_name'] = this.clientName;
    data['employee_name'] = this.employeeName;
    data['task_complete_percentage'] = this.taskCompletePercentage;
    return data;
  }
}

class GraphData {
  String? month;
  String? complete;
  String? totalTask;

  GraphData({this.month, this.complete, this.totalTask});

  GraphData.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    complete = json['complete'];
    totalTask = json['total_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['complete'] = this.complete;
    data['total_task'] = this.totalTask;
    return data;
  }
}

class LoginTime {
  String? id;
  String? userId;
  String? inTime;
  String? outTime;
  String? createdOn;
  String? createdBy;
  String? dl;

  LoginTime(
      {this.id,
      this.userId,
      this.inTime,
      this.outTime,
      this.createdOn,
      this.createdBy,
      this.dl});

  LoginTime.fromJson(Map<String, dynamic> json) {
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

class Holiday {
  String? id;
  String? title;
  String? description;
  String? date;
  String? createdOn;
  String? showToUsers;
  String? dl;

  Holiday(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.createdOn,
      this.showToUsers,
      this.dl});

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    createdOn = json['created_on'];
    showToUsers = json['show_to_users'];
    dl = json['dl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['created_on'] = this.createdOn;
    data['show_to_users'] = this.showToUsers;
    data['dl'] = this.dl;
    return data;
  }
}
