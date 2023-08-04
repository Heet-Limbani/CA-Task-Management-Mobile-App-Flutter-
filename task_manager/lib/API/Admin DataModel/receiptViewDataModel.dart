class ReceiptViewDataModel {
  Company? company;
  Data? data;
  List<InvoicePaymentId>? invoicePaymentId;
  List<InvoiceData>? invoiceData;

  ReceiptViewDataModel({this.company, this.data, this.invoicePaymentId, this.invoiceData});

  ReceiptViewDataModel.fromJson(Map<String, dynamic> json) {
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['invoice_payment_id'] != null) {
      invoicePaymentId = <InvoicePaymentId>[];
      json['invoice_payment_id'].forEach((v) {
        invoicePaymentId!.add(new InvoicePaymentId.fromJson(v));
      });
    }
    if (json['invoice_data'] != null) {
      invoiceData = <InvoiceData>[];
      json['invoice_data'].forEach((v) {
        invoiceData!.add(new InvoiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.invoicePaymentId != null) {
      data['invoice_payment_id'] =
          this.invoicePaymentId!.map((v) => v.toJson()).toList();
    }
    if (this.invoiceData != null) {
      data['invoice_data'] = this.invoiceData!.map((v) => v.toJson()).toList();
    }
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

class Data {
  String? id;
  String? paytmOrderId;
  String? amount;
  String? date;
  String? clientId;
  String? paymentMethod;
  String? status;
  String? referenceNumber;
  String? description;

  Data(
      {this.id,
      this.paytmOrderId,
      this.amount,
      this.date,
      this.clientId,
      this.paymentMethod,
      this.status,
      this.referenceNumber,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paytmOrderId = json['paytm_order_id'];
    amount = json['amount'];
    date = json['date'];
    clientId = json['client_id'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    referenceNumber = json['reference_number'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paytm_order_id'] = this.paytmOrderId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['client_id'] = this.clientId;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['reference_number'] = this.referenceNumber;
    data['description'] = this.description;
    return data;
  }
}

class InvoicePaymentId {
  String? id;
  String? invoiceId;
  String? paymentId;
  String? clientId;
  String? amount;
  String? createdOn;

  InvoicePaymentId(
      {this.id,
      this.invoiceId,
      this.paymentId,
      this.clientId,
      this.amount,
      this.createdOn});

  InvoicePaymentId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    paymentId = json['payment_id'];
    clientId = json['client_id'];
    amount = json['amount'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['payment_id'] = this.paymentId;
    data['client_id'] = this.clientId;
    data['amount'] = this.amount;
    data['created_on'] = this.createdOn;
    return data;
  }
}

class InvoiceData {
  String? id;
  String? invoiceNo;
  String? clientId;
  String? dateOf;
  String? total;
  String? otherDetails;
  String? paymentId;
  String? paymentStatus;
  String? privateDetails;
  String? customInvoice;
  String? dateOfCreate;
  String? dateOfUpdate;
  String? createdBy;
  String? companyName;

  InvoiceData(
      {this.id,
      this.invoiceNo,
      this.clientId,
      this.dateOf,
      this.total,
      this.otherDetails,
      this.paymentId,
      this.paymentStatus,
      this.privateDetails,
      this.customInvoice,
      this.dateOfCreate,
      this.dateOfUpdate,
      this.createdBy,
      this.companyName});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    clientId = json['client_id'];
    dateOf = json['date_of'];
    total = json['total'];
    otherDetails = json['other_details'];
    paymentId = json['payment_id'];
    paymentStatus = json['payment_status'];
    privateDetails = json['private_details'];
    customInvoice = json['custom_invoice'];
    dateOfCreate = json['date_of_create'];
    dateOfUpdate = json['date_of_update'];
    createdBy = json['created_by'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_no'] = this.invoiceNo;
    data['client_id'] = this.clientId;
    data['date_of'] = this.dateOf;
    data['total'] = this.total;
    data['other_details'] = this.otherDetails;
    data['payment_id'] = this.paymentId;
    data['payment_status'] = this.paymentStatus;
    data['private_details'] = this.privateDetails;
    data['custom_invoice'] = this.customInvoice;
    data['date_of_create'] = this.dateOfCreate;
    data['date_of_update'] = this.dateOfUpdate;
    data['created_by'] = this.createdBy;
    data['company_name'] = this.companyName;
    return data;
  }
}