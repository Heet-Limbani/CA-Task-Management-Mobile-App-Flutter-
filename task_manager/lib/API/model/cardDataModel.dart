class CardData {
  Card? cardData; // Change the property type to Card?

  CardData({
    this.cardData,
  });

  CardData.fromJson(Map<String, dynamic> json) {
    cardData = json['card_data'] != null
        ? Card.fromJson(json['card_data']) // Update the constructor call
        : null;
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
  List<Pending>? pending;

  Card({
    this.pending,
  });

  Card.fromJson(Map<String, dynamic> json) {
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }

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
