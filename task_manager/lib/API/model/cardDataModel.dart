class CardData {
  Card? cardData;

  CardData({
    this.cardData,
  });

  CardData.fromJson(Map<String, dynamic> json) {
    cardData =
        json['card_data'] != null ? Card.fromJson(json['card_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardData != null) {
      data['card_data'] = this.cardData!.toJson();
    }
    return data;
  }
}

class Card {
  List<Pending>? pending1;
  List<TotalOverdueTask>? overdue;
  List<Tasks>? tasks;

  Card({
    this.pending1,
    this.overdue,
    this.tasks,
  });

  Card.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending1 = <Pending>[];
      json['pending'].forEach((v) {
        pending1!.add(Pending.fromJson(v));
      });
    }
    if (json['total_overdue_task'] != null) {
      overdue = <TotalOverdueTask>[];
      json['total_overdue_task'].forEach((v) {
        overdue!.add(TotalOverdueTask.fromJson(v));
      });
    }
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pending1 != null) {
      data['pending'] = this.pending1!.map((v) => v.toJson()).toList();
    }
    if (this.overdue != null) {
      data['total_overdue_task'] =
          this.overdue!.map((v) => v.toJson()).toList();
    }
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
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

  TotalOverdueTask({
    this.ticketId,
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
    this.taskCompletePercentage,
  });

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
    final _data = <String, dynamic>{};
    _data['ticket_id'] = ticketId;
    _data['unique_id'] = uniqueId;
    _data['created_by'] = createdBy;
    _data['client_id'] = clientId;
    _data['file_id'] = fileId;
    _data['category_id'] = categoryId;
    _data['dep_id'] = depId;
    _data['group_id'] = groupId;
    _data['starting_date'] = startingDate;
    _data['deadline_date'] = deadlineDate;
    _data['mode'] = mode;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    _data['created_on'] = createdOn;
    _data['closed_on'] = closedOn;
    _data['updated_on'] = updatedOn;
    _data['date_of_comletion'] = dateOfComletion;
    _data['date_of_holding'] = dateOfHolding;
    _data['last_reply_by_id'] = lastReplyById;
    _data['last_reply_by_text'] = lastReplyByText;
    _data['amount'] = amount;
    _data['transaction_id'] = transactionId;
    _data['invoice_date'] = invoiceDate;
    _data['invoice_no'] = invoiceNo;
    _data['auto_complete_and_review'] = autoCompleteAndReview;
    _data['auto_invoice'] = autoInvoice;
    _data['dl'] = dl;
    _data['ctitle'] = ctitle;
    _data['cstatus'] = cstatus;
    _data['subtask_id'] = subtaskId;
    _data['cdeadline_date'] = cdeadlineDate;
    _data['priority'] = priority;
    _data['client_name'] = clientName;
    _data['employee_name'] = employeeName;
    _data['task_complete_percentage'] = taskCompletePercentage;
    return _data;
  }
}
