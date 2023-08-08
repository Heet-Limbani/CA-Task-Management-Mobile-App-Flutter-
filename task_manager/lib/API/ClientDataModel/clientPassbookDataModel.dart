class ClientPassbookDataModel {
  CompanyData? companyData;
  int? invoiceCount;
  List<InvoiceData>? invoiceData;
  int? paymentCount;
  List<PaymentDate>? paymentDate;

  ClientPassbookDataModel(
      {this.companyData,
      this.invoiceCount,
      this.invoiceData,
      this.paymentCount,
      this.paymentDate});

  ClientPassbookDataModel.fromJson(Map<String, dynamic> json) {
    companyData = json['company_data'] != null
        ? new CompanyData.fromJson(json['company_data'])
        : null;
    invoiceCount = json['invoice_count'];
    if (json['invoice_data'] != null) {
      invoiceData = <InvoiceData>[];
      json['invoice_data'].forEach((v) {
        invoiceData!.add(new InvoiceData.fromJson(v));
      });
    }
    paymentCount = json['payment_count'];
    if (json['payment_date'] != null) {
      paymentDate = <PaymentDate>[];
      json['payment_date'].forEach((v) {
        paymentDate!.add(new PaymentDate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companyData != null) {
      data['company_data'] = this.companyData!.toJson();
    }
    data['invoice_count'] = this.invoiceCount;
    if (this.invoiceData != null) {
      data['invoice_data'] = this.invoiceData!.map((v) => v.toJson()).toList();
    }
    data['payment_count'] = this.paymentCount;
    if (this.paymentDate != null) {
      data['payment_date'] = this.paymentDate!.map((v) => v.toJson()).toList();
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
  String? company;

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
      this.company});

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
    company = json['company'];
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
    data['company'] = this.company;
    return data;
  }
}

class PaymentDate {
  String? id;
  String? paytmOrderId;
  String? amount;
  String? date;
  String? clientId;
  String? paymentMethod;
  String? status;
  String? referenceNumber;
  String? description;
  String? clientName;

  PaymentDate(
      {this.id,
      this.paytmOrderId,
      this.amount,
      this.date,
      this.clientId,
      this.paymentMethod,
      this.status,
      this.referenceNumber,
      this.description,
      this.clientName});

  PaymentDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paytmOrderId = json['paytm_order_id'];
    amount = json['amount'];
    date = json['date'];
    clientId = json['client_id'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    referenceNumber = json['reference_number'];
    description = json['description'];
    clientName = json['client_name'];
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
    data['client_name'] = this.clientName;
    return data;
  }
}